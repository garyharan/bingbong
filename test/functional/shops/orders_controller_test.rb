require 'test_helper'

class Shops::OrdersControllerTest < ActionController::TestCase
  setup do
    @shop     = Factory.create(:shop)
    @category = Factory.create(:category, :shop     => @shop)
    @product  = Factory.create(:product,  :category => @category)
    @size     = Factory.create(:size,     :category => @category)
    @item     = Item.first
    @item.update_attribute :price, 2.99

    @client = Factory.create(:client)
    @delivery_address = Factory(:delivery_address, :client => @shop.owner)

    @order = Factory.create(:order, :shop => @shop, :delivery_address => @delivery_address)
    @order.lines << Factory.build(:line, :shop_id => @shop.id, :item => @item)

    sign_in @shop.owner
  end

  test "should render list of order" do
    get :index, :shop_id => @shop.id
    assert_not_nil assigns(:shop)
    assert_not_nil assigns(:orders)
  end

  test "should accept order" do
    post :accept, :shop_id => @shop.to_param, :id => @order.to_param
    assert_redirected_to shop_shop_orders_url(:shop_id => @shop.to_param)
    assert @order.reload.accepted?, "order didn't change state"
    assert_match /accept/i, flash[:notice]
  end

  test "should refuse order" do
    post :refuse, :shop_id => @shop.to_param, :id => @order.to_param
    assert_redirected_to shop_shop_orders_url(:shop_id => @shop.to_param)
    assert @order.reload.refused?, "order didn't change state"
    assert_match /refus/i, flash[:notice]
  end

  test "should route accordingly" do
    assert_routing({:method => :post, :path => "/shops/17/orders/21/accept"}, :controller => "shops/orders", :action => "accept", :shop_id => "17", :id => "21")
    assert_routing({:method => :post, :path => "/shops/17/orders/21/refuse"}, :controller => "shops/orders", :action => "refuse", :shop_id => "17", :id => "21")
  end
end
