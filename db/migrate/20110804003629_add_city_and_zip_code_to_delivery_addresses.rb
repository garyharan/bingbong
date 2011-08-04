class AddCityAndZipCodeToDeliveryAddresses < ActiveRecord::Migration
  def self.up
    add_column :delivery_addresses, :city, :string
    add_column :delivery_addresses, :zip_code, :string
  end

  def self.down
    remove_column :delivery_addresses, :city
    remove_column :delivery_addresses, :zip_code
  end
end
