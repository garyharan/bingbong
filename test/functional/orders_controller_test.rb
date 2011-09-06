require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @shop     = Factory.create(:shop)
    @category = Factory.create(:category, :shop     => @shop)
    @product  = Factory.create(:product,  :category => @category)
    @size     = Factory.create(:size,     :category => @category)
    @item     = Item.first
    @item.update_attribute :price, 2.99

    @delivery_address = Factory(:delivery_address)
    sign_in @delivery_address.client
  end

  test "should get index orders for current user" do
    get :index
    assert_not_nil assigns(:orders)
    assert_response :success
  end

  test "should get new" do
    @line = Factory.create(:line, :shop_id => @shop.id, :item => @item, :client => @delivery_address.client)
    get :new, :order => { :shop_id => @shop.id }

    assert_not_nil assigns(:shop)
    assert_not_nil assigns(:order)
    assert_not_nil assigns(:lines)
    assert_not_nil assigns(:delivery_address)
    assert_equal "new", assigns(:current_address_id)
    assert_response :success
  end

  test "should create an order" do
    @line = Factory.create(:line, :client => @delivery_address.client, :shop_id => @shop.id, :item => @item, :quantity => 2)
    assert_difference 'Order.count' do
      post :create, :order => { :shop_id => @shop.id, :delivery_address_id => @delivery_address.id }
    end
    assert_equal @delivery_address.id, assigns(:order).delivery_address_id
    assert_not_nil assigns(:order)
    assert_equal 1, assigns(:order).lines.count
    assert_redirected_to order_path(assigns(:order))
  end

  test "should show an order" do
    @order = Factory.create(:order, :delivery_address => @delivery_address, :shop => @shop)
    @line  = @order.lines.create!(
      Factory.attributes_for(:line, :client => @delivery_address.client, :shop_id => @shop.id, :item => @item, :quantity => 2))
    get :show, :id => @order.id
    assert_response :success
  end
end
