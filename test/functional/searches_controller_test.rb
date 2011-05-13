require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search" do
    assert_difference('Search.count') do
      post :create, :search => Factory.attributes_for(:search)
    end

    assert_redirected_to search_path(assigns(:search))
  end

  test "should not create a second search if the search location already exists" do
    Search.create Factory.attributes_for(:search)
    assert_no_difference('Search.count') do
      post :create, :search => Factory.attributes_for(:search)
    end

    assert_redirected_to search_path(assigns(:search))
  end

  test "should show search" do
    @search = Search.create Factory.attributes_for(:search)
    get :show, :id => @search.to_param
    assert_response :success
  end
  
  test "user should have saved search if logged in" do
    @user = User.create Factory.attributes_for :user
    sign_in @user
    assert_difference('@user.searches.count') do
      post :create, :search => Factory.attributes_for(:search)
    end
  end
end
