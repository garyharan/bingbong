require 'test_helper'

class ShopsControllerTest < ActionController::TestCase
  setup do
    @user = Factory.create :user
    @shop = Factory.create :shop, :user_id => @user.id
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop" do
    assert_difference('Shop.count') do
      assert_difference('@user.shops.count') do
        post :create, :shop => Factory.new(:shop).attributes
      end
    end

    assert_redirected_to shop_path(assigns(:shop))
    assert_equal @user.id, assigns(:shop).user_id
  end

  test "should show shop" do
    get :show, :id => @shop.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @shop.to_param
    assert_response :success
  end

  test "should update shop" do
    put :update, :id => @shop.to_param, :shop => @shop.attributes
    assert_redirected_to shop_path(assigns(:shop))
  end

  test "should destroy shop" do
    assert_difference('Shop.count', -1) do
      delete :destroy, :id => @shop.to_param
    end

    assert_redirected_to shops_path
  end
end