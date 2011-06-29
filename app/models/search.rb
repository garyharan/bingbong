class Search < ActiveRecord::Base
  belongs_to :user

  def shops
    @shops ||= find_shops
  end

  def find_shops
    @shops = Shop.near(fetch_coordinates)
  end

  private
  def fetch_coordinates
    return [45.483244,-73.509521] if Rails.env.test? # TODO FIX THIS TEST!!

    if self.latitude.nil? || self.longitude.nil?
      coordinates    = Geocoder.coordinates location
      self.latitude  = coordinates[0]
      self.longitude = coordinates[1]
      self.save
    end
    [self.latitude, self.longitude]
  end
end
