class Skill < ActiveRecord::Base
  validates :title, :years, :presence => true
  belongs_to :candidate
end
