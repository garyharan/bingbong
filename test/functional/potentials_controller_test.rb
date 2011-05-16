require 'test_helper'

class PotentialsControllerTest < ActionController::TestCase
  setup do
    @potential = Potential.create Factory.attributes_for(:potential)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create potential" do
    assert_difference('Potential.count') do
      post :create, :potential => Factory.attributes_for(:potential)
    end

    assert_redirected_to potential_path(assigns(:potential))
  end

  test "should show potential" do
    get :show, :id => @potential.to_param
    assert_response :success
  end
end
