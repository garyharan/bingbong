require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @user = User.create!(Factory.attributes_for(:user))
    @shop = Shop.create!(Factory.attributes_for(:shop, :user_id => @user.id))
    sign_in @user
  end

  test "should create a category" do
    assert_difference('Category.count') do
      post :create, :category => Factory.attributes_for(:category), :shop_id => @shop.id
    end
    assert_not_nil assigns(:shop)
    assert_not_nil assigns(:category)
    assert_response :success
  end
end
