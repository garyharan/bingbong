class DeliveryAddress < ActiveRecord::Base
  has_many :user

  attr_accessible :address, :apartment, :phone_number, :note

  validates_presence_of :address, :phone_number
  validates_format_of :phone_number, :with => /\d{3}-\d{3}-\d{4}/
end
