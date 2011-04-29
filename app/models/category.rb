class Category < ActiveRecord::Base
  belongs_to :shop
  has_many :sizes, :dependent => :destroy
  has_many :products, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :shop_id
end
