require 'test_helper'

class SizesControllerTest < ActionController::TestCase
  setup do
    @user     = User.create!(Factory.attributes_for(:user))
    @shop     = Shop.create!(Factory.attributes_for(:shop, :user_id => @user.id))
    @category = Category.create!(Factory.attributes_for(:category, :shop_id => @shop.id))
    @item     = Item.create!(Factory.attributes_for(:item, :category_id => @category.id))
    sign_in @user
  end
  
  test "create a size for an item" do
    assert_difference '@item.sizes.count' do
      xhr :post, :create, :size => Factory.attributes_for(:size), :item_id => @item.id
    end

    assert_not_nil assigns(:size)
    assert_response :success
  end
end
