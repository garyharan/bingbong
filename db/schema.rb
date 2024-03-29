# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111005172644) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delivery_addresses", :force => true do |t|
    t.integer  "client_id"
    t.string   "address"
    t.string   "apartment"
    t.string   "phone_number"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",      :default => false
    t.string   "city"
    t.string   "zip_code"
  end

  create_table "items", :force => true do |t|
    t.decimal  "price",      :precision => 5, :scale => 2
    t.integer  "product_id"
    t.integer  "size_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lines", :force => true do |t|
    t.integer  "client_id"
    t.integer  "shop_id"
    t.integer  "item_id"
    t.integer  "quantity",   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  create_table "order_state_transitions", :force => true do |t|
    t.integer  "order_id",   :null => false
    t.string   "column",     :null => false
    t.string   "from",       :null => false
    t.string   "to",         :null => false
    t.string   "event",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "state",               :default => "pending"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "refused_at"
    t.datetime "accepted_at"
    t.integer  "delivery_address_id"
    t.string   "call_state",          :default => "pending", :null => false
    t.text     "validation_code"
    t.integer  "gm_points"
  end

  add_index "orders", ["call_state"], :name => "index_orders_on_call_state"

  create_table "potentials", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "phone"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "searches", :force => true do |t|
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "shops", :force => true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "city"
    t.string   "address"
    t.string   "province"
    t.string   "country"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.decimal  "minimum",      :precision => 5, :scale => 2, :default => 15.0
    t.integer  "delivery",                                   :default => 30
    t.float    "latitude"
    t.float    "longitude"
    t.text     "description"
  end

  create_table "sizes", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_blocks", :force => true do |t|
    t.integer  "shop_id"
    t.integer  "weekday"
    t.integer  "starting"
    t.integer  "ending"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                               :default => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "categories", ["shop_id"], "shops", ["id"], :name => "categories_shop_id_fkey"

  add_foreign_key "delivery_addresses", ["client_id"], "users", ["id"], :name => "delivery_addresses_user_id_fkey"

  add_foreign_key "items", ["product_id"], "products", ["id"], :on_delete => :cascade, :name => "items_product_id_fkey"
  add_foreign_key "items", ["size_id"], "sizes", ["id"], :name => "items_size_id_fkey"

  add_foreign_key "lines", ["item_id"], "items", ["id"], :name => "lines_item_id_fkey"
  add_foreign_key "lines", ["order_id"], "orders", ["id"], :name => "lines_order_id_fkey"

  add_foreign_key "orders", ["delivery_address_id"], "delivery_addresses", ["id"], :name => "orders_delivery_address_id_fkey"
  add_foreign_key "orders", ["shop_id"], "shops", ["id"], :name => "orders_shop_id_fkey"

  add_foreign_key "products", ["category_id"], "categories", ["id"], :name => "products_category_id_fkey"

  add_foreign_key "searches", ["client_id"], "users", ["id"], :name => "searches_user_id_fkey"

  add_foreign_key "shops", ["owner_id"], "users", ["id"], :name => "shops_user_id_fkey"

  add_foreign_key "sizes", ["category_id"], "categories", ["id"], :name => "sizes_category_id_fkey"

end
