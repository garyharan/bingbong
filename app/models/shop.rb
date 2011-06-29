class Shop < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  has_many :categories, :order => 'created_at ASC'

  geocoded_by :full_address
  after_validation :geocode
  before_validation do
    normalized = self.postal_code.upcase.gsub(/[^A-Z0-9]/, "")
    normalized = "#{normalized[0, 3]} #{normalized[3, 3]}"
    self.postal_code = normalized
  end

  def full_address
    [address, city, province, postal_code].join(", ")
  end

  def owned_by?(owner)
    owner.id == user_id
  end
end
