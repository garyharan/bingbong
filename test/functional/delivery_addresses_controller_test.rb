require 'test_helper'

class DeliveryAddressesControllerTest < ActionController::TestCase
  setup do
    @delivery_address = delivery_addresses(:one)
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

    assert_redirected_to delivery_address_path(assigns(:delivery_address))
  end

  test "should show delivery_address" do
    get :show, :id => @delivery_address.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @delivery_address.to_param
    assert_response :success
  end

  test "should update delivery_address" do
    put :update, :id => @delivery_address.to_param, :delivery_address => @delivery_address.attributes
    assert_redirected_to delivery_address_path(assigns(:delivery_address))
  end

  test "should destroy delivery_address" do
    assert_difference('DeliveryAddress.count', -1) do
      delete :destroy, :id => @delivery_address.to_param
    end

    assert_redirected_to delivery_addresses_path
  end
end
