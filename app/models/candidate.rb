class Candidate < ActiveRecord::Base
  validates :first_name, :last_name, :presence => true
  has_many :skills
end
