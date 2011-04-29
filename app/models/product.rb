class Product < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :category_id

  def after_create
    category.sizes.each do |size|
      Item.create :product_id => id, :size_id => size.id
    end
  end
end
