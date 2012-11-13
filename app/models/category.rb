class Category < ActiveRecord::Base
  # User-friendly category name.
  validates :name, presence: true, uniqueness: true, length: 1..32
  attr_accessible :name

  has_many :problems, dependent: :destroy
end
