require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  test "owned_by?(user) works" do
    @user = Factory.build :user
    @shop = Factory.build :shop, :user_id => @user.id
    assert @shop.owned_by?(@user)

    @not_mine = Factory.build :shop
    assert @not_mine.owned_by?(@user) == false, "user should not own this shop"
  end

  test "full address displays correctly" do
    @shop = Factory.build :shop
    assert_equal "150 Woodland Avenue, Dartmouth, Nova Scotia, B2W 2X6", @shop.full_address
  end
end
