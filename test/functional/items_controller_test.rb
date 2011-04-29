require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @user = User.create!(Factory.attributes_for(:user))
    @shop = Shop.create!(Factory.attributes_for(:shop, :user_id => @user.id))
    @category = Category.create!(Factory.attributes_for(:category, :shop_id => @shop.id))
    sign_in @user
  end

  test "should create an item" do
    assert_difference('Item.count') do
      xhr :post, :create, :item => Factory.attributes_for(:item), :category_id => @category.id
    end
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:item)
    assert !assigns(:item).errors.any?
    assert_response :success
  end

  test "should update an item" do
    @item = Item.create Factory.attributes_for(:item, :category_id => @category.id)
    xhr :put, :update, :item => { :name => "New Name"}, :category_id => @category.id, :id => @item.id
    assert_equal "New Name", assigns(:item).name
  end
end
