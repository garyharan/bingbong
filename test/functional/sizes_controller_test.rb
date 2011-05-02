require 'test_helper'

class SizesControllerTest < ActionController::TestCase
   setup do
    @user = User.create!(Factory.attributes_for(:user))
    @shop = Shop.create!(Factory.attributes_for(:shop, :user_id => @user.id))
    @category = Category.create!(Factory.attributes_for(:category, :shop_id => @shop.id))
    sign_in @user
  end

  test "should create a size" do
    assert_difference('Size.count') do
      post :create, :size => Factory.attributes_for(:size), :category_id => @category.id, :shop_id => @shop.id
    end
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:size)
    assert !assigns(:size).errors.any?
    assert_redirected_to shop_path(@shop)
  end

  test "should update a size's name" do
    @size = Size.create Factory.attributes_for(:size, :category_id => @category.id)
    xhr :put, :update, :size => { :name => "macdonald" }, :shop_id => @shop.id, :category_id => @category.id, :id => @size.id
    assert_equal "macdonald", assigns(:size).name
    assert_response :success
  end

  test "should delete a size" do
    @size = Size.create Factory.attributes_for(:size, :category_id => @category.id)
    assert_difference 'Size.count', -1 do
      delete :destroy, :id => @size.id, :shop_id => @shop.id, :category_id => @category.id
    end
    assert_redirected_to @shop
  end
end
