class Product < ActiveRecord::Base
  belongs_to :category
  has_many :items
  has_many :sizes, :through => :items

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :category_id

  delegate :shop, :to => :category

  after_create :create_items
  def create_items
    category.sizes.each do |size|
      Item.create :product_id => id, :size_id => size.id
    end
  end

  after_destroy :destroy_items
  def destroy_items
    Item.destroy_all :product_id => id
  end
end
