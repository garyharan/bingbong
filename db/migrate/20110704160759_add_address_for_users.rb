class AddAddressForUsers < ActiveRecord::Migration
  def self.up
    create_table :delivery_addresses do |t|
      t.integer :user_id
      t.string :address
      t.string :apartment
      t.string :phone_number
      t.string :note
    end

    add_foreign_key :delivery_addresses, :user_id, :users, :id
  end

  def self.down
    drop_table :delivery_addresses
  end
end
