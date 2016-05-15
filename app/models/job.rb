class Job < ActiveRecord::Base
  validates :title, :salary, :job_type, :description, :about, :presence => true
  belongs_to :company
  has_many :requirements
end
