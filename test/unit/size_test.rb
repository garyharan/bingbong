require 'test_helper'

class SizeTest < ActiveSupport::TestCase
  setup do
    @shop      = Factory.create :shop
    @category  = @shop.categories.create Factory.attributes_for(:category, :shop_id      => @shop.id)
    @product_1 = @category.products.create Factory.attributes_for(:product, :category_id => @category.id)
    @product_2 = @category.products.create Factory.attributes_for(:product, :category_id => @category.id)
  end

  test "when we create a new size there should be items created for them automatically" do
    assert_difference "Item.count", Product.count * (Size.count+1) do
      @size = Size.create Factory.attributes_for(:size, :category_id => @category.id)
    end
  end
end
