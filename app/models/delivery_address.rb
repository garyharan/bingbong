class DeliveryAddress < ActiveRecord::Base
  belongs_to :user

  attr_accessible :user_id, :address, :apartment, :phone_number, :note

  validates_presence_of :user_id, :address, :phone_number
  validates_format_of :phone_number, :with => /\d{3}-\d{3}-\d{4}/
end
