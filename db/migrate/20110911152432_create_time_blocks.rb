class CreateTimeBlocks < ActiveRecord::Migration
  def self.up
    create_table :time_blocks do |t|
      t.integer :shop_id
      t.integer :weekday
      t.integer :starting
      t.integer :ending

      t.timestamps
    end
  end

  def self.down
    drop_table :time_blocks
  end
end
