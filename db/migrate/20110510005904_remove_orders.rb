class RemoveOrders < ActiveRecord::Migration
  def self.up
    drop_table :orders
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
