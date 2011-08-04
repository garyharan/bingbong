class DeliveryAddress < ActiveRecord::Base
  belongs_to :user

  has_many :orders

  attr_accessible :user_id, :address,:apartment, :city,  :zip_code, :phone_number, :note

  validates_presence_of :user_id, :address, :city, :zip_code, :phone_number
  validates_format_of :phone_number, :with => /\d{3}-\d{3}-\d{4}/
  validates_format_of :zip_code, :with => /[a-z]\d[a-z] \d[a-z]\d/i
end
