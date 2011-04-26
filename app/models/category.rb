class Category < ActiveRecord::Base
  belongs_to :shop
  has_many :items

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :shop_id
end
