class Candidate < ActiveRecord::Base
  validates :first_name, :last_name, :presence => true
  has_many :skills
  has_one :address
end
