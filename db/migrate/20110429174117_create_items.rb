class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.decimal :price, :precision => 5, :scale => 2
      t.integer :product_id
      t.integer :size_id

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
