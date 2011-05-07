class ChangeLatLngToLatitudeLongitude < ActiveRecord::Migration
  def self.up
    rename_column :shops, :lat, :latitude
    rename_column :shops, :lng, :longitude
  end

  def self.down
    rename_column :shops, :latitude,  :lat
    rename_column :shops, :longitude, :lng
  end
end
