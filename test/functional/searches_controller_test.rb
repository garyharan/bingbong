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
    Factory.create(:search, :client => nil)
    assert_no_difference('Search.count') do
      post :create, :search => Factory.attributes_for(:search)
    end

    assert_redirected_to search_path(assigns(:search))
  end

  test "should show search" do
    @search = Factory.create(:search, :client => nil)
    get :show, :id => @search.to_param
    assert_not_nil assigns(:search)
    assert_response :success
  end

  test "user should have saved search if logged in" do
    @client = Factory.create(:client)
    sign_in @client
    assert_difference('@client.searches.count') do
      post :create, :search => Factory.attributes_for(:search)
    end
  end

  test "should delete search" do
    @search = Factory.create(:search)
    sign_in @search.client
    assert_difference '@search.client.searches.count', -1 do
      delete :destroy, :id => @search.id
    end
    assert_redirected_to searches_path
  end

  test "should have default search" do
    search = Factory.create(:search)
    delivery_address = Factory.create(:delivery_address, :client => search.client)
    sign_in search.client

    get :index
    assert_equal [delivery_address], assigns(:delivery_addresses)
  end
end
