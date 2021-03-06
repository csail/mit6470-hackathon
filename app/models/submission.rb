require 'net/http'
require 'net/https'

# An attempt to solve a problem.
class Submission < ActiveRecord::Base
  # The user who made this submission.
  belongs_to :user
  validates :user, presence: true
  # NOTE: user* should _not_ be attr_accessible

  # The problem that the user is attempting to solve.
  belongs_to :problem
  validates :problem, presence: true
  attr_accessible :problem_id, :problem

  # The IP of the browser that made this submission.
  validates :remote_ip, presence: true, length: 1..128
  # NOTE: remote_ip should _not_ be attr_accessible

  # The code that the user wrote to solve the problem.
  validates :code, presence: true, length: 0..1.megabyte
  attr_accessible :code

  # The result of grading this submission.
  has_one :verdict, dependent: :destroy

  # Syntactic sugar.
  scope :for_user, lambda { |user| where user_id: user.id }
  scope :for_problem, lambda { |problem| where problem_id: problem.id }
  scope :recent_first, lambda { order 'created_at DESC' }

  # Score assigned by the grading endpoint.
  def score
    verdict ? (verdict.score * problem.weight / verdict.max_score.to_f) : 0
  end
  def score=(new_score)
    new_score = new_score.to_f
    if verdict
      verdict.score = (new_score / problem.weight) * verdict.max_score.to_f
      verdict.save!
    end
    new_score
  end
  attr_accessible :score, as: :active_admin

  # Maximum score this submission could have received.
  def max_score
    problem.weight
  end

  # True if the user got a full score on the problem.
  def accepted?
    verdict && verdict.accepted?
  end

  # Short message describing the grading endpoint's decision.
  def verdict_message
    verdict ? verdict.message : 'Queued'
  end
  def verdict_message=(new_verdict_message)
    if verdict
      verdict.message = new_verdict_message
      verdict.save!
    end
    new_verdict_message
  end
  attr_accessible :verdict_message=, as: :active_admin

  # Queues up the submission to a grading endpoint in a worker task.
  def queue_for_grading
    delay.grade!
  end
  after_create :queue_for_grading

  # Blocking HTTP RPC to the grading endpoint.
  def grade!
    uri = URI.parse problem.endpoint.url
    response = Net::HTTP.post_form uri, task: problem.task_name, code: code
    verdict = Verdict.from_endpoint_response response, self
    verdict.save!
  end
end
