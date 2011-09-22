require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  should have_many(:orders)
  should have_many(:categories)

  test "owned_by?(owner) works" do
    @shop = Factory.build :shop
    assert @shop.owned_by?(@shop.owner), "owner should own this shop."

    @not_mine = Factory.build(:shop)
    assert @not_mine.owned_by?(@shop.owner) == false, "owner should not own this shop"
  end

  test "full address displays correctly" do
    @shop = Factory.build :shop
    assert_equal "1514 Murray Street, Saint-Hubert, Quebec, J4T1C7", @shop.full_address
  end

  test "open? should work" do
    @shop = Factory.build :shop
    @shop.save!
    # monday_block = Factory.build :time_block, :shop_id => @shop.id # 
    @shop.time_blocks.create :starting => 1000, :ending => 2200, :weekday => 1
    stub(Time).now { Time.new 2011, 7, 11, 11, 30 } # monday 11th of July 2011 11h30AM
    assert @shop.open?, "shop should be opened"
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
