class AddForeignKeysForResiliency < ActiveRecord::Migration
  def self.up
    add_foreign_key :orders, :shop_id, :shops, :id
    add_foreign_key :orders, :user_id, :users, :id

    add_foreign_key :items, :product_id, :products, :id, :on_delete => :cascade
    add_foreign_key :items, :size_id, :sizes, :id

    add_foreign_key :lines, :order_id, :orders, :id
    add_foreign_key :lines, :item_id, :items, :id

    add_foreign_key :categories, :shop_id, :shops, :id

    add_foreign_key :shops, :user_id, :users, :id

    add_foreign_key :sizes, :category_id, :categories, :id

    add_foreign_key :products, :category_id, :categories, :id

    add_foreign_key :searches, :user_id, :users, :id
  end

  def self.down
  end
end
