# A response from a grading endpoint.
class Verdict < ActiveRecord::Base
  belongs_to :submission
  validates :submission, presence: true
  validates :submission_id, presence: true, uniqueness: true
  attr_accessible :submission

  # Maximum score received by the submission.
  validates :score, presence: true,
      numericality: { greater_than_or_equal_to: 0 }

  # Maxium score the submission could have gotten.
  validates :max_score, presence: true,
      numericality: { greater_than_or_equal_to: 0 }

  # Brief verdict description from the endpoint.
  validates :message, length: 1..1024

  # HTML response page from the endpoint.
  validates :response_html, length: 1..1.megabyte, presence: true

  def self.from_endpoint_response(http_response, submission)
    verdict = Verdict.new submission: submission
    verdict.submission = submission
    verdict.response_html = http_response.body

    if http_response.kind_of? Net::HTTPOK
      score = http_response['X-Grader-Score']
      max_score = http_response['X-Grader-Maxscore']
      message = http_response['X-Grader-Verdict']
      if score && max_score && message
        verdict.score = BigDecimal.new score
        verdict.max_score = BigDecimal.new max_score
        verdict.message = message
      else
        verdict.score = 0
        verdict.max_score = 1
        verdict.message = 'Grading endpoint API error'
      end
    else
      verdict.score = 0
      verdict.max_score = 1
      verdict.message = "Grading endpoint error: #{http_response.message}"
    end
    verdict
  end

  # True if the user shouldn't re-submit for the same problem.
  def accepted?
    score == max_score
  end
end
