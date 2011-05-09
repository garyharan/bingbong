require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "should provide proper name of item" do
    @shop     = Shop.create     Factory.attributes_for(:shop)
    @category = Category.create Factory.attributes_for(:category, :shop_id => @shop.id)
    @product  = Product.create  Factory.attributes_for(:product, :category_id => @category.id)
    @size     = Size.create     Factory.attributes_for(:size, :category_id => @category.id)
    @item     = Item.create     Factory.attributes_for(:item, :product_id => @product.id, :size_id => @size.id)
    assert_equal @product.name, @item.name
  end
end
