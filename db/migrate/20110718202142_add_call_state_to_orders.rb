class AddCallStateToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :call_state, :string, :null => false, :default => "pending"
  end

  def self.down
    remove_column :orders, :call_state
  end
end
