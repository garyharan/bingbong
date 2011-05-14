require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @user = User.create!(Factory.attributes_for(:user))
    sign_in @user 
    @shop     = Shop.create     Factory.attributes_for(:shop)
    @category = Category.create Factory.attributes_for(:category, :shop_id => @shop.id)
    @product  = Product.create  Factory.attributes_for(:product, :category_id => @category.id)
    @size     = Size.create     Factory.attributes_for(:size, :category_id => @category.id)
    @item     = Item.first
    @item.update_attribute :price, 2.99
  end

  test "should get new" do
    get :new, :order => { :shop_id => @shop.id }
    assert_response :success
  end

  test "should create an order" do
    @line = Line.create :user_id => @user.id, :shop_id => @shop.id, :item_id => @item.id, :quantity => 2
    assert_difference 'Order.count' do
      post :create, :order => { :shop_id => @shop.id }
    end
    assert_not_nil assigns(:order)
    assert_equal 1, assigns(:order).lines.count
    assert_redirected_to order_path(assigns(:order))
  end

  test "should show an order" do
    @order = Order.create :user_id => @user.id, :shop_id => @shop.id
    @line = Line.create :user_id => @user.id, :shop_id => @shop.id, :item_id => @item.id, :quantity => 2, :order_id => @order.id
    get :show, :id => @order.id
    assert_response :success
  end
end
