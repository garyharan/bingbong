class CreateLines < ActiveRecord::Migration
  def self.up
    create_table :lines do |t|
      t.integer :user_id
      t.integer :shop_id
      t.integer :item_id
      t.integer :quantity, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :lines
  end
end
