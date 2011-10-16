# coding : utf-8
class DeliveryAddress < ActiveRecord::Base

  belongs_to :client, :class_name => "User"

  has_many :orders

  attr_accessible :client_id, :address, :apartment, :city,  :zip_code, :phone_number, :note

  scope :current, where(:deleted => false)

  REGEXP_PHONE_NUMBER = /\A\(?(\d{3})\)?[-\s]*(\d{3})[-\s]*(\d{4})\z/
  REGEXP_ZIP_CODE = /\A([a-z]\d[a-z]) ?(\d[a-z]\d\z)/i

  validates_presence_of :client_id, :address, :city, :zip_code, :phone_number
  validates_format_of :phone_number, :with => REGEXP_PHONE_NUMBER
  validates_format_of :zip_code, :with => REGEXP_ZIP_CODE

  # Removes leading and trailing spaces
  before_validation { self.phone_number = self.phone_number.strip }
  before_validation { self.zip_code = self.zip_code.strip }

  before_save :normalize_phone_number, :if => :phone_number_changed?
  before_save :normalize_zip_code,     :if => :zip_code_changed?

  def formatted_phone_number
    if phone_number.blank? || !(REGEXP_PHONE_NUMBER === phone_number)
      ""
    else
      "(#{$1}) #{$2}-#{$3}"
    end
  end

  def formatted_zip_code
    if zip_code.blank? || !(REGEXP_ZIP_CODE === zip_code)
      ""
    else
      "#{ $1.upcase } #{ $2.upcase }"
    end
  end

  def expanded_address
    address.gsub(/st-/i, "saint-")
  end

  def expanded_city
    city.gsub(/st-/i, "saint-")
  end

  def address_string
    a = expanded_address
    a += ", appartement #{apartment}" unless apartment.blank?
    a += ", #{expanded_city}, téléphone #{phone_number}"
    a += ", note, #{note}" unless note.blank?

    a
  end

  private

  def normalize_phone_number
   self.phone_number = self.phone_number.gsub(/\D/, "")
  end

  def normalize_zip_code
    self.zip_code = self.zip_code.upcase.gsub(/\s/, "")
  end

end
