class Search < ActiveRecord::Base
  belongs_to :user

  def shops
    @shops ||= find_shops
  end

  def find_shops
    @coordinates = Geocoder.coordinates location
    @shops = Shop.near(@coordinates)
  end
end
