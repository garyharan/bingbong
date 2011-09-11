require 'test_helper'

class TimeBlocksControllerTest < ActionController::TestCase
  setup do
    @shop       = Factory.create(:shop)
    @time_block = Factory.create(:time_block, :shop_id => @shop.id)
  end

  test "should get index" do
    get :index, :shop_id => @shop.id
    assert_response :success
    assert_not_nil assigns(:time_blocks)
  end

  test "should get new" do
    get :new, :shop_id => @shop.id
    assert_response :success
  end

  test "should create time_block" do
    assert_difference('TimeBlock.count') do
      post :create, :time_block => @time_block.attributes, :shop_id => @shop.id
    end

    assert_not_nil assigns(:time_block)
    assert_redirected_to shop_time_blocks_path
  end

  test "should show time_block" do
    get :show, :id => @time_block.to_param, :shop_id => @shop.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @time_block.to_param, :shop_id => @shop.id
    assert_response :success
  end

  test "should update time_block" do
    put :update, :id => @time_block.to_param, :time_block => @time_block.attributes, :shop_id => @shop.id
    assert_redirected_to shop_time_block_path(@shop, assigns(:time_block))
  end

  test "should destroy time_block" do
    assert_difference('TimeBlock.count', -1) do
      delete :destroy, :id => @time_block.to_param, :shop_id => @shop.id
    end

    assert_redirected_to shop_time_blocks_path
  end
end
