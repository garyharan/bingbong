require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  test "owned_by?(user) works" do
    @user = Factory.build :user
    @shop = Factory.build :shop, :user_id => @user.id
    assert @shop.owned_by?(@user), "user should owne this shop."

    @not_mine = Factory.build(:shop, :user_id => -1)
    assert @not_mine.owned_by?(@user) == false, "user should not own this shop"
  end

  test "full address displays correctly" do
    @shop = Factory.build :shop
    assert_equal "1514 Murray Street, Saint-Hubert, Quebec, J4T1C7", @shop.full_address
  end

  # test "geocodes shops after validation" do
  #   stub(Geocoder).coordinates().returns([45.537405, -73.510726])
  #   @shop = Shop.create Factory.attributes_for(:shop, :address => "1514 Murray Street")
  #   assert_equal 45.493409,   @shop.latitude
  #   assert_equal -73.4576584, @shop.longitude
  # end
end
