class CreateShops < ActiveRecord::Migration
  def self.up
    create_table :shops do |t|
      t.string :name
      t.string :phone_number
      t.string :city
      t.string :address
      t.string :province
      t.string :country
      t.string :postal_code

      t.timestamps
    end
  end

  def self.down
    drop_table :shops
  end
end
