class CreateOrderStateTransitions < ActiveRecord::Migration
  def self.up
    create_table :order_state_transitions do |t|
      t.belongs_to :order, :null => false
      t.string :column, :null => false
      t.string :from, :to, :null => false
      t.string :event, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :order_state_transitions
  end
end
