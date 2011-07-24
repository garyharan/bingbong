require 'test_helper'

class DeliveryAddressesControllerTest < ActionController::TestCase
  setup do
    @user = User.create!(Factory.attributes_for(:user))
    @user.confirm!
    sign_in @user 
    @delivery_address = DeliveryAddress.create!(Factory.attributes_for(:delivery_address).merge(:user_id => @user.id))
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delivery_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery_address" do
    assert_difference('DeliveryAddress.count') do
      post :create, :delivery_address => @delivery_address.attributes
    end

    assert_redirected_to delivery_addresses_path
  end

  test "should get edit" do
    get :edit, :id => @delivery_address.to_param
    assert_response :success
  end

  test "should update delivery_address" do
    @request.env["HTTP_REFERER"] = "back"
    put :update, :id => @delivery_address.to_param, :delivery_address => @delivery_address.attributes
    assert_redirected_to "back"
  end

  test "should destroy delivery_address" do
    @request.env["HTTP_REFERER"] = "back"
    assert_difference('DeliveryAddress.count', -1) do
      delete :destroy, :id => @delivery_address.to_param
    end

    assert_redirected_to "back"
  end
end
