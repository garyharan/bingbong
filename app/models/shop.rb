class Shop < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  has_many :orders
  has_many :categories, :order => 'created_at ASC'

  geocoded_by :full_address
  after_validation :geocode
  before_validation do
    normalized = self.postal_code.to_s.upcase.gsub(/[^A-Z0-9]/, "")
    normalized = "#{normalized[0, 3]} #{normalized[3, 3]}"
    self.postal_code = normalized
  end

  def full_address
    [address, city, province, postal_code].join(", ")
  end

  def owned_by?(owner)
    self.owner == owner
  end

  def delivery_fee_to(delivery_address)
    BigDecimal.new("4.99")
  end
end
