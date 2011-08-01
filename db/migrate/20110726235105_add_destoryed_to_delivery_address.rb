class AddDestoryedToDeliveryAddress < ActiveRecord::Migration
  def self.up
    add_column :delivery_addresses, :deleted, :boolean, :default => false
  end

  def self.down
    remove_column :delivery_addresses, :deleted
  end
end
