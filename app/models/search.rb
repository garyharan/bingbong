class Search < ActiveRecord::Base
  belongs_to :client, :class_name => "User"

  def shops
    @shops ||= find_shops
  end

  def find_shops
    @shops = Shop.near(fetch_coordinates).select { |shop| 
      shop.open? # FIXME why the fuck can't I use the scope here?
    }
  end

  private
  def fetch_coordinates
    if self.latitude.nil? || self.longitude.nil?
      coordinates = Geocoder.coordinates location
      if coordinates then
        self.latitude  = coordinates[0]
        self.longitude = coordinates[1]
        self.save
      end
    end

    [self.latitude, self.longitude]
  end
end
