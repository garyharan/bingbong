class IndexOrdersCallState < ActiveRecord::Migration
  def self.up
    add_index :orders, :call_state
  end

  def self.down
    remove_index :orders, :column => :call_state
  end
end
