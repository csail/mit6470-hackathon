# A grading endpoint.
class Endpoint < ActiveRecord::Base
  # User-friendly name for the endpoint.
  validates :name, length: 1..128, uniqueness: true
  attr_accessible :name

  # Grading URL.
  validates :url, length: 1..256, uniqueness: true
  attr_accessible :url
end
