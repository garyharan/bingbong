class Search < ActiveRecord::Base
  def shops
    @shops ||= find_shops
  end

  def find_shops
    @coordinates = Geocoder.coordinates location
    @shops = Shop.near(@coordinates)
  end
end
