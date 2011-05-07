require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get find" do
    stub(Geocoder).coordinates().returns([45.537405, -73.510726])
    get :find, :address => "100 Murray Street, St-Hubert"
    assert_not_nil assigns(:shops)
    assert_response :success
  end
end
