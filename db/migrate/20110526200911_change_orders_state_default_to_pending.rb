class ChangeOrdersStateDefaultToPending < ActiveRecord::Migration
  def self.up
    change_column_default(:orders, :state, :pending)
    add_column :orders, :refused_at, :datetime
    add_column :orders, :accepted_at, :datetime
  end

  def self.down
    change_column_default(:orders, :state, nil)
    remove_column :orders, :refused_at
    remove_column :orders, :accepted_at
  end
end
