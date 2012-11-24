# Category of problems, such as CSS, JavaScript, SQL.
class Category < ActiveRecord::Base
  # User-friendly category name.
  validates :name, presence: true, uniqueness: true, length: 1..32
  attr_accessible :name, as: :active_admin

  has_many :problems, dependent: :destroy
end
