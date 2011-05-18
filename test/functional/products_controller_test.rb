require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @user = User.create!(Factory.attributes_for(:user))
    @user.confirm!
    @shop = Shop.create!(Factory.attributes_for(:shop, :user_id => @user.id))
    @category = Category.create!(Factory.attributes_for(:category, :shop_id => @shop.id))
    sign_in @user
  end

  test "should create a product" do
    assert_difference('Product.count') do
      post :create, :product => Factory.attributes_for(:product), :category_id => @category.id, :shop_id => @shop.id
    end
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:product)
    assert !assigns(:product).errors.any?
    assert_redirected_to shop_path(@shop)
  end

  test "should update an product" do
    @product = Product.create Factory.attributes_for(:product, :category_id => @category.id)
    put :update, :product => { :name => "New Name"}, :category_id => @category.id, :id => @product.id, :shop_id => @shop.id
    assert_equal "New Name", assigns(:product).name
  end

  test "should delete a product" do
    @product = Product.create Factory.attributes_for(:product, :category_id => @category.id)
    assert_difference 'Product.count', -1 do
      delete :destroy, :category_id => @category.id, :id => @product.id, :shop_id => @shop.id
    end
    assert_redirected_to shop_path(@shop)
  end
end
