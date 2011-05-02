class Size < ActiveRecord::Base
  belongs_to :category

  after_create :create_items
  def create_items
    category.products.each do |product|
      Item.create :product_id => product.id, :size_id => id
    end
  end
end