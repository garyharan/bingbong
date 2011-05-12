class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :state
      t.integer :user_id
      t.integer :shop_id

      t.timestamps
    end
    add_column :lines, :order_id, :integer
  end

  def self.down
    drop_table :orders
    remove_column :lines, :order_id
  end
end
