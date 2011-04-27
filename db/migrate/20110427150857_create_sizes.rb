class CreateSizes < ActiveRecord::Migration
  def self.up
    create_table :sizes do |t|
      t.string :name
      t.decimal :price, :precision => 5, :scale => 2 # 999.99 is maximum price with this.
      t.integer :item_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sizes
  end
end
