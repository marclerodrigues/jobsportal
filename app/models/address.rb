class Address < ActiveRecord::Base
  validates :street, :city, :state, :presence => true
end
