class OrdersUseDeliveryOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :delivery_address_id, :integer
    remove_column :orders, :address
    remove_column :orders, :appartment
    remove_column :orders, :phone_number
    remove_column :orders, :note
    remove_column :orders, :user_id

    add_foreign_key :orders, :delivery_address_id, :delivery_addresses, :id
  end

  def self.down
    remove_column :orders, :delivery_address_id
    add_column :orders, :address, :string
    add_column :orders, :appartment, :string
    add_column :orders, :phone_number, :string
    add_column :orders, :note, :text
    add_column :orders, :user_id, :integer
  end
end
