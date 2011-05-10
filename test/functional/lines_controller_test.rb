require 'test_helper'

class LinesControllerTest < ActionController::TestCase
  setup do
    @user = User.create!(Factory.attributes_for(:user))
    sign_in @user 
  end

  test "should create a line" do
    @shop = Shop.create Factory.attributes_for(:shop)
    @item = Item.create Factory.attributes_for(:item)
    assert_difference 'Line.count' do
      xhr :put, :create, :line => { :shop_id => @shop.id, :item_id => @item.id }
    end
  end
end
