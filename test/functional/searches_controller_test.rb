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
    assert_not_nil assigns(:search)
    assert_response :success
  end
  
  test "user should have saved search if logged in" do
    @user = User.create Factory.attributes_for :user
    sign_in @user
    @user.confirm!
    assert_difference('@user.searches.count') do
      post :create, :search => Factory.attributes_for(:search)
    end
  end

  test "should delete search" do
    @user = User.create Factory.attributes_for :user
    @user.confirm!
    @search = Search.create Factory.attributes_for(:search, :user_id => @user.id)
    sign_in @user
    assert_difference '@user.searches.count', -1 do
      delete :destroy, :id => @search.id
    end
    assert_redirected_to searches_path
  end

  test "should have default search" do
    @user = User.create Factory.attributes_for :user
    @user.confirm!
    search = Search.create(Factory.attributes_for(:search, :user_id => @user.id))
    delivery_address = DeliveryAddress.create(Factory.attributes_for(:delivery_address, :user_id => @user.id))
    order = Order.create(Factory.attributes_for(:order, :delivery_address_id => delivery_address.id, :shop_id => Factory(:shop).id))
    sign_in @user

    get :index
    assert_equal [search], assigns(:searches)
    assert_equal [delivery_address], assigns(:delivery_addresses)
    assert_equal [order], assigns(:orders)
  end
end
