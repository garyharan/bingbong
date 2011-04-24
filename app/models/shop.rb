class Shop < ActiveRecord::Base
  belongs_to :user
  has_many :categories

  def full_address
    [address, city, province, postal_code].join(", ")
  end

  def owned_by?(owner)
    owner.id == user_id
  end
end
