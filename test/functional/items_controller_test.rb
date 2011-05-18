require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @user     = User.create!(Factory.attributes_for(:user))
    @user.confirm!
    @shop     = Shop.create!(Factory.attributes_for(:shop, :user_id         => @user.id))
    @category = Category.create!(Factory.attributes_for(:category, :shop_id => @shop.id))
    @product  = Product.create!(Factory.attributes_for(:product, :category_id => @category.id))
    @size     = Size.create!(Factory.attributes_for(:size, :category => @category))
    sign_in @user
  end

  test "should update an item" do
    @item = Item.create(Factory.attributes_for(:item, :product_id => @product.id, :size_id => @size.id))
    xhr :put, :update, :item => Factory.attributes_for(:item, :price => "1.25"), :id => @item.id, :shop_id => @shop.id, :category_id => @category.id
    assert_equal 1.25, assigns(:item).price
  end
end
