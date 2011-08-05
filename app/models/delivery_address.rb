class DeliveryAddress < ActiveRecord::Base

  belongs_to :client, :class_name => "User"

  has_many :orders

  attr_accessible :client_id, :address, :apartment, :city,  :zip_code, :phone_number, :note

  scope :current, where(:deleted => false)

  validates_presence_of :client_id, :address, :city, :zip_code, :phone_number
  validates_format_of :phone_number, :with => /\A\(?\d{3}\)?[-\s]*\d{3}[-\s]*\d{4}\z/ # Accepts separators for data entry, but normalized to no separators
  validates_format_of :zip_code,     :with => /\A[a-z]\d[a-z] ?\d[a-z]\d\z/i          # Accepts separators for data entry, but normalized to no separators

  # Removes leading and trailing spaces
  before_validation { self.phone_number = self.phone_number.strip }
  before_validation { self.zip_code = self.zip_code.strip }

  before_save :normalize_phone_number, :if => :phone_number_changed?
  before_save :normalize_zip_code,     :if => :zip_code_changed?

  def formatted_phone_number
    return "" if phone_number.blank?

    area_code = phone_number[0, 3]
    exchange  = phone_number[3, 3]
    number    = phone_number[6, 4]

    "(#{area_code}) #{exchange}-#{number}"
  end

  def formatted_zip_code
    return "" if zip_code.blank?

    "#{ zip_code[0, 3] } #{ zip_code[3, 3] }"
  end

  private

  def normalize_phone_number
   self.phone_number = self.phone_number.gsub(/\D/, "")
  end

  def normalize_zip_code
    self.zip_code = self.zip_code.upcase.gsub(/\s/, "")
  end

end
