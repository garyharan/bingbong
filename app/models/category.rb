class Category < ActiveRecord::Base
  belongs_to :shop
  validates_uniqueness_of :name, :scope => :shop_id
end
