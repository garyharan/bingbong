class RenameItemsToProducts < ActiveRecord::Migration
  def self.up
    rename_table :items, :products
  end

  def self.down
    rename_table :products, :items
  end
end
