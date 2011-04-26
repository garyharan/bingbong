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
    assert_nil assigns(:item).errors
    assert_response :success
  end

end
