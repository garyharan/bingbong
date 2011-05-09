class Shop < ActiveRecord::Base
  belongs_to :user
  has_many :categories, :order => 'created_at ASC'
  has_many :orders

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [address, city, province, postal_code].join(", ")
  end

  def owned_by?(owner)
    owner.id == user_id
  end
end
