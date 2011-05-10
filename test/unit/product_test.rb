require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @shop      = Factory.create :shop
    @category  = @shop.categories.create Factory.attributes_for(:category, :shop_id      => @shop.id)
    @size      = @category.sizes.create Factory.attributes_for(:size, :category_id => @category.id)
  end

  test "should create items when a new product is created if sizes already exist for it" do
    assert_difference "Item.count" do
      Product.create Factory.attributes_for(:product, :category_id => @category.id)
    end
  end

  test "should delete all connected items when product is deleted" do
    @product = Product.create Factory.attributes_for(:product, :category_id => @category.id)
    assert_difference "Item.count", -1 do 
      @product.destroy
    end
  end

  test "should let me know what shop it is" do
    @product = Product.create Factory.attributes_for(:product, :category_id => @category.id)
    assert_equal @shop.id, @product.shop.id
  end
end
