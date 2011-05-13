class AddLatLngToSearches < ActiveRecord::Migration
  def self.up
    add_column :searches, :latitude,  :float
    add_column :searches, :longitude, :float
  end

  def self.down
    remove_column :searches, :latitude
    remove_column :searches, :longitude
  end
end
