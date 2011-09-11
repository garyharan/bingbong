require 'test_helper'

class SizeTest < ActiveSupport::TestCase
  setup do
    @shop      = Factory.create :shop
    @category  = @shop.categories.create Factory.attributes_for(:category, :shop_id      => @shop.id)
  end

  test "when we create a new size there should be items created for them automatically" do
    @product_1 = @category.products.create Factory.attributes_for(:product, :category_id => @category.id)
    @product_2 = @category.products.create Factory.attributes_for(:product, :category_id => @category.id)
    assert_difference "Item.count", Product.count * (Size.count+1) do
      @size = Size.create Factory.attributes_for(:size, :category_id => @category.id)
    end
  end

  test "items should be deleted if related to a size" do
    Product.destroy_all
    Size.destroy_all
    Item.destroy_all
    @product = Product.create   Factory.attributes_for(:product,  :category_id => @category.id)
    @size    = Size.create      Factory.attributes_for(:size,     :category_id => @category.id)
    assert_difference "Item.count", -1 do
      @size.destroy
    end
  end

  test '#order_name should replace double quote by inches' do
    assert_equal Factory.create(:size, :name => '3"').order_name,  "3 pouces"
    assert_equal Factory.create(:size, :name => '3 "').order_name, "3 pouces"
    assert_equal Factory.create(:size, :name => '1 "').order_name, "1 pouce"
  end

  test "#order_name should replace quote by feet" do
    assert_equal Factory.create(:size, :name => "3 '").order_name, "3 pieds"
    assert_equal Factory.create(:size, :name => "3'").order_name,  "3 pieds"
    assert_equal Factory.create(:size, :name => "1 '").order_name, "1 pied"
  end

end
