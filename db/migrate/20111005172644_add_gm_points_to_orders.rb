class AddGmPointsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :gm_points, :int
    execute "update orders set gm_points = 10"
  end

  def self.down
    remove_column :orders, :gm_points
  end
end
