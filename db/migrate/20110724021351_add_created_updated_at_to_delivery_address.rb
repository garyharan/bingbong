class AddCreatedUpdatedAtToDeliveryAddress < ActiveRecord::Migration
  def self.up

    add_column :delivery_addresses, :created_at, :datetime
    add_column :delivery_addresses, :updated_at, :datetime
  end

  def self.down
    drop_column :delivery_addresses, :created_at
    drop_column :delivery_addresses, :updated_at
  end
end
