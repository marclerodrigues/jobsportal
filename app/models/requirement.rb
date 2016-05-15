class Requirement < ActiveRecord::Base
  validates :title, :years, :presence => true
  belongs_to :job
end
