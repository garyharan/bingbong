require 'test_helper'

class DeliveryAddressesControllerTest < ActionController::TestCase
  setup do
    @delivery_address = Factory.create(:delivery_address)
    sign_in @delivery_address.client
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
      xhr :post, :create, :delivery_address => @delivery_address.attributes
    end

    assert_template :create, "we did not render the rjs file create.js.erb"
    assert_response :success
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
    assert_difference('DeliveryAddress.where(:deleted => true).count', 1) do
      xhr :delete, :destroy, :id => @delivery_address.to_param
    end

    assert_template :destroy, "we did not render the rjs file destroy.js.erb"
    assert_response :success
  end
end
