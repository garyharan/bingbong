require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @shop = Factory.create(:shop)
    @category = Factory.create(:category, :shop => @shop)
    sign_in @shop.owner
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

  test "should update a product name" do
    @product = Factory.create(:product, :category => @category)
    put :update, :product => { :name => "New Name" }, :category_id => @category.id, :id => @product.id, :shop_id => @shop.id
    assert_equal "New Name", assigns(:product).name
    assert_equal "name", assigns(:attribute)
  end

  test "should update a product description" do
    @product = Factory.create(:product, :category => @category)
    put :update, :product => { :description => "New description"}, :category_id => @category.id, :id => @product.id, :shop_id => @shop.id
    assert_equal "New description", assigns(:product).description
    assert_equal "description", assigns(:attribute)
  end

  test "should delete a product" do
    @product = Factory.create(:product, :category => @category)
    assert_difference 'Product.count', -1 do
      delete :destroy, :category_id => @category.id, :id => @product.id, :shop_id => @shop.id
    end

    assert_redirected_to shop_path(@shop)
  end
end
