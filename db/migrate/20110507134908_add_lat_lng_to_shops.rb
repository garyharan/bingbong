class AddLatLngToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :lat, :float, :precision => 10, :scale => 6
    add_column :shops, :lng, :float, :precision => 10, :scale => 6
  end

  def self.down
    remove_column :shops, :lat
    remove_column :shops, :lng
  end
end
