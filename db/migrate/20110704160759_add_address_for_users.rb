class AddAddressForUsers < ActiveRecord::Migration
  def self.up
    create_table :delivery_addresses do |t|
      t.string :address
      t.string :apartment
      t.string :phone_number
      t.string :note
    end

    add_column :users, :delivery_address_id,       :integer
  end

  def self.down
    remove_column :users, :delivery_address_id
    drop_table :delivery_addresses
  end
end
