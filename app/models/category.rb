class Category < ActiveRecord::Base
  belongs_to :shop
  has_many :sizes, :dependent => :destroy, :order => 'created_at ASC'
  has_many :products, :dependent => :destroy, :order => 'created_at ASC'

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :shop_id
end
