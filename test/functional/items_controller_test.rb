require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @shop     = Factory.create(:shop)
    @category = Factory.create(:category, :shop => @shop)
    @product  = Factory.create(:product,  :category => @category)
    @size     = Factory.create(:size,     :category => @category)
    sign_in @shop.owner
  end

  test "should update an item" do
    @item = Factory.create(:item, :product => @product, :size => @size)
    xhr :put, :update, :item => Factory.attributes_for(:item, :price => "1.25"), :id => @item.id, :shop_id => @shop.id, :category_id => @category.id
    assert_equal "1.25", assigns(:item).price.to_s
  end
end
