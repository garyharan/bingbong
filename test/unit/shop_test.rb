require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  test "owned_by?(user) works" do
    @user = Factory.build :user
    @shop = Factory.build :shop, :user_id => @user.id
    assert @shop.owned_by?(@user)

    @not_mine = Factory.build :shop
    assert @not_mine.owned_by?(@user) == false, "user should not own this shop"
  end
end
