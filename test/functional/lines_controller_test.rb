require 'test_helper'

class LinesControllerTest < ActionController::TestCase
  setup do
    @user = User.create!(Factory.attributes_for(:user))
    sign_in @user 
    @shop     = Shop.create     Factory.attributes_for(:shop)
    @category = Category.create Factory.attributes_for(:category, :shop_id => @shop.id)
    @product  = Product.create  Factory.attributes_for(:product, :category_id => @category.id)
    @size     = Size.create     Factory.attributes_for(:size, :category_id => @category.id)
  end

  test "should create a line" do
    @item     = Item.first
    @item.update_attribute :price, 2.99
    assert_difference 'Line.count' do
      xhr :post, :create, :line => { :shop_id => @shop.id, :item_id => @item.id }
    end
    assert_not_nil assigns(:line)
    assert_not_nil assigns(:lines)
  end

  test "should change quantity on create if a line already exists" do
    @item     = Item.first
    @item.update_attribute :price, 2.99
    @line     = Line.create(:user_id => @user.id, :shop_id => @shop.id, :item_id => @item.id)
    assert_no_difference 'Line.count' do
      xhr :post, :create, :line => { :shop_id => @shop.id, :item_id => @item.id }
    end
    assert_not_nil assigns(:line)
    assert_equal 2, assigns(:line).quantity
  end

  test "should update quantity" do
    @item     = Item.first
    @line     = Line.create(:user_id => @user.id, :shop_id => @shop.id, :item_id => @item.id)
    xhr :put, :update, :line => { :quantity => 3 }, :id => @line.id
    assert_equal 3, assigns(:line).quantity
  end
end