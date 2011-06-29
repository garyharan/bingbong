require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  should have_many(:orders)
  should have_many(:categories)

  test "owned_by?(user) works" do
    @user = Factory.build :user
    @shop = Factory.build :shop, :user_id => @user.id
    assert @shop.owned_by?(@user), "user should own this shop."

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

  test "normalizes postal code" do
    shop = Factory.build(:shop)

    # Uppercases the postal code
    shop.postal_code = "j1g3n3"; shop.valid?
    assert_equal "J1G 3N3", shop.postal_code

    # Trims and strips extraneous spaces
    shop.postal_code = " J1g   3x3 "; shop.valid?
    assert_equal "J1G 3X3", shop.postal_code
  end
end
