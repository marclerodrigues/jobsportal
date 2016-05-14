class Company < ActiveRecord::Base
  validates :name, :about, presence: :true
end
