require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  test "lat/lng should save to db if find_shops is used" do
    @shop = Factory.build :shop
    @coordinates = [45.55555, -73.55555]
    stub(Geocoder).coordinates().returns(@coordinates)
    @search = Search.create Factory.attributes_for :search
    @search.find_shops
    assert_equal @coordinates[0], @search.latitude
    assert_equal @coordinates[1], @search.longitude
  end

  test "don't break when Geocoder returns nothing from a call" do
    @shop = Factory.build :shop
    @coordinates = [45.55555, -73.55555]
    stub(Geocoder).coordinates().returns(nil)
    @search = Search.create Factory.attributes_for :search

    assert_nothing_raised do
      @search.find_shops
    end
  end
end
