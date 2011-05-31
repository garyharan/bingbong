require 'test_helper'

class Shops::OrdersControllerTest < ActionController::TestCase
  setup do
    @user = User.create!(Factory.attributes_for(:user))
    @user.confirm!
    sign_in @user 
    @shop     = Shop.create     Factory.attributes_for(:shop)
    @category = Category.create Factory.attributes_for(:category, :shop_id => @shop.id)
    @product  = Product.create  Factory.attributes_for(:product, :category_id => @category.id)
    @size     = Size.create     Factory.attributes_for(:size, :category_id => @category.id)
    @item     = Item.first
    @item.update_attribute :price, 2.99
  end

  test "should get index" do
    get :index, :shop_id => @shop.id
    assert_not_nil assigns(:shop)
    assert_not_nil assigns(:orders)
  end
end
