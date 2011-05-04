class AddMinimumAndExpectedDeliveryTimeToShop < ActiveRecord::Migration
  def self.up
    add_column :shops, :minimum,  :decimal, :precision => 5, :scale => 2, :default => "15.00"
    add_column :shops, :delivery, :integer, :default => 30
  end

  def self.down
    remove_column :shops, :minimum
    remove_column :shops, :delivery
  end
end
