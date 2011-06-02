class AddAddressToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :address,       :string
    add_column :orders, :appartment,    :string
    add_column :orders, :phone_number,  :string
    add_column :orders, :note,          :text
  end

  def self.down
    remove_column :orders, :address
    remove_column :orders, :appartment
    remove_column :orders, :phone_number
    remove_column :orders, :note
  end
end
