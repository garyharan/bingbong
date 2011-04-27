require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @user = User.create!(Factory.attributes_for(:user))
    @shop = Shop.create!(Factory.attributes_for(:shop, :user_id => @user.id))
    sign_in @user
  end

  test "should create a category" do
    assert_difference('Category.count') do
      xhr :post, :create, :category => Factory.attributes_for(:category), :shop_id => @shop.id
    end
    assert_not_nil assigns(:shop)
    assert_not_nil assigns(:category)
    assert_response :success
  end

  test "should update a category" do
    @category = Category.create(Factory.attributes_for(:category, :name => "Old Name", :shop_id => @shop.id))
    xhr :put, :update, :category => Factory.attributes_for(:category, :name => "New name"), :shop_id => @shop.id, :id => @category.id
    assert_equal "New name", assigns(:category).name
  end
end
