require 'test_helper'

class LinesControllerTest < ActionController::TestCase
  setup do
    @shop     = Factory.create(:shop)
    @category = Factory.create(:category, :shop => @shop)
    @product  = Factory.create(:product,  :category => @category)
    @size     = Factory.create(:size,     :category => @category)
    @item     = Item.first
    @item.update_attribute :price, 2.99

    @user = Factory.create(:client)
    sign_in @user
  end

  test "should create a line" do
    assert_difference 'Line.count' do
      xhr :post, :create, :line => { :shop_id => @shop.id, :item_id => @item.id }
    end
    assert_not_nil assigns(:line)
    assert_not_nil assigns(:lines)
  end

  test "should only return lines not already part of an order" do
    Line.create(:shop => @shop, :item => @item, :order => Factory.create(:order))
    assert_difference 'Line.count' do
      xhr :post, :create, :line => { :shop_id => @shop.id, :item_id => @item.id }
    end
    assert_equal 1, assigns(:lines).count
  end

  test "should change quantity on create if a line already exists" do
    @line = Line.create(:client_id => @user.id, :shop_id => @shop.id, :item_id => @item.id)
    assert_no_difference 'Line.count' do
      xhr :post, :create, :line => { :shop_id => @shop.id, :item_id => @item.id }
    end
    assert_not_nil assigns(:line)
    assert_equal 2, assigns(:line).quantity
  end

  test "should update quantity" do
    @line = Line.create(:client_id => @user.id, :shop_id => @shop.id, :item_id => @item.id)
    xhr :put, :update, :line => { :quantity => 3 }, :id => @line.id
    assert_equal 3, assigns(:line).quantity
    assert_not_nil assigns(:lines)
  end

  test "should delete line if quantity set to 0" do
    @line = Line.create(:client_id => @user.id, :shop_id => @shop.id, :item_id => @item.id)
    assert_difference 'Line.count', -1  do
      xhr :put, :update, :line => { :quantity => 0 }, :id => @line.id
    end
    assert_equal 0, assigns(:line).quantity
    assert_equal 0, assigns(:lines).count
  end
end
