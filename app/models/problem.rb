# Metadata for problems solved by users.
class Problem < ActiveRecord::Base
  # CSS, JS, SQL.
  belongs_to :category
  validates :category, presence: true
  attr_accessible :category_id, :category, as: :active_admin

  # User-friendly name.
  validates :name, presence: true, uniqueness: true, length: 1..128
  attr_accessible :name, as: :active_admin

  # Grading endpoint-friendly name.
  validates :task_name, presence: true, length: 1..32, format: /^[\w-]+$/
  attr_accessible :task_name, as: :active_admin

  # The grading endpoint that receives submissions for this problem.
  belongs_to :endpoint
  validates :endpoint, presence: true
  attr_accessible :endpoint_id, :endpoint, as: :active_admin

  # Whether users can access the problem.
  validates :published, inclusion: { in: [true, false] }
  attr_accessible :published, as: :active_admin

  # Problem's weight in the scoring.
  validates :weight, presence: true, numericality: { greater_than: 0 }
  attr_accessible :weight, as: :active_admin

  # Raw HTML shown on the problem page.
  validates :description_html, presence: true, length: 1..1.megabyte
  attr_accessible :description_html, as: :active_admin

  # Default value for the code field in a new submission.
  validates :starter_code, presence: true, length: 1..16.kilobytes
  attr_accessible :starter_code, as: :active_admin

  # User submissions for this problem.
  has_many :submissions, dependent: :destroy

  # True if a user is allowed to see a problem and submit solutions to it.
  def visible_to?(user)
    !!user && published?
  end

  # Presentation :(
  def long_name
    "#{category.name}: #{name}"
  end
end
