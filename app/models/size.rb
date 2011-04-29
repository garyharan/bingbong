class Size < ActiveRecord::Base
  belongs_to :category

  def after_create
    category.products.each do |product|
      Item.create :product_id => product.id, :size_id => id
    end
  end
end
