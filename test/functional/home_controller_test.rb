require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_not_nil assigns(:shops)
    assert_response :success
  end
end
