require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @shop      = Factory.create :shop
    @category  = @shop.categories.create Factory.attributes_for(:category, :shop_id      => @shop.id)
    @size      = @category.sizes.create Factory.attributes_for(:size, :category_id => @category.id)
  end

  test "should create items when a new product is created if sizes already exist for it" do
    assert_difference "Item.count" do
      @size = Product.create Factory.attributes_for(:product, :category_id => @category.id)
    end
  end
end
