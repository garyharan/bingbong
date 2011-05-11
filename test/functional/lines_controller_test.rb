require 'test_helper'

class LinesControllerTest < ActionController::TestCase
  setup do
    @user = User.create!(Factory.attributes_for(:user))
    sign_in @user 
  end

  test "should create a line" do
    @shop     = Shop.create     Factory.attributes_for(:shop)
    @category = Category.create Factory.attributes_for(:category, :shop_id => @shop.id)
    @product  = Product.create  Factory.attributes_for(:product, :category_id => @category.id)
    @size     = Size.create     Factory.attributes_for(:size, :category_id => @category.id)
    @item     = Item.first
    @item.update_attribute :price, 2.99
    assert_difference 'Line.count' do
      xhr :post, :create, :line => { :shop_id => @shop.id, :item_id => @item.id }
    end
    assert_not_nil assigns(:line)
  end

  test "should change quantity on create if a line already exists" do
    @shop     = Shop.create     Factory.attributes_for(:shop)
    @category = Category.create Factory.attributes_for(:category, :shop_id => @shop.id)
    @product  = Product.create  Factory.attributes_for(:product, :category_id => @category.id)
    @size     = Size.create     Factory.attributes_for(:size, :category_id => @category.id)
    @item     = Item.first
    @item.update_attribute :price, 2.99
    @line     = Line.create(:user_id => @user.id, :shop_id => @shop.id, :item_id => @item.id)
    assert_no_difference 'Line.count' do
      xhr :post, :create, :line => { :shop_id => @shop.id, :item_id => @item.id }
    end
    assert_not_nil assigns(:line)
    assert_equal 2, assigns(:line).quantity
  end
end
