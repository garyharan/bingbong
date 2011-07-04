# coding : utf-8
# use incremental values for ids for consistency
shop = category = size = item = 0

pizza_unik = Shop.create! :name => "Pizza Unik", :phone_number => "450-926-9111", 
              :city => "Saint-Hubert", :address => "3742 Grande Allée", 
              :province => "Quebec", :country => "Canada",
              :postal_code => "J4T 2V2", :user_id => 2,
              :delivery => 15, :latitude => 45.4914023, :longitude => -73.4684749


pizza_category = Category.create! :name => "Pizzas", :shop_id => pizza_unik.id
Size.create! :name => '12"', :category_id => pizza_category.id
Size.create! :name => '14"', :category_id => pizza_category.id
Size.create! :name => '16"', :category_id => pizza_category.id
Size.create! :name => '18"', :category_id => pizza_category.id

marinara = Product.create! :name => "Marinara"
Item.create! :product_id => marinara.id

sandwichs_category = Category.create! :name => "Sandwichs", :shop_id => pizza_unik.id
Size.create! :name => '', :category_id => sandwichs_category.id

boissons_category = Category.create! :name => "Boissons", :shop_id => pizza_unik.id
Size.create! :name => '300ml', :category_id => boissons_category.id
Size.create! :name => '2l', :category_id => boissons_category.id

orientalis = Shop.create! :name => "Orientalis", :phone_number => "555-555-5555", 
              :city => "Saint-Hubert", :address => "4190 Grande Allée", :province => "QC", 
              :country => "Canada", :postal_code => "J4V 3N2", :user_id => 1, :minimum => 15, 
              :delivery => 30, :latitude => 45.4863035, :longitude => -73.4600382
