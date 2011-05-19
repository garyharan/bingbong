# use incremental values for ids for consistency
shop = category = size = item = 0

pizza_unik = Shop.create! :id => shop++, :name => "Pizza Unik", :phone_number => "450-926-9111", 
              :city => "Saint-Hubert", :address => "3742 Grande Allée", 
              :province => "Quebec", :country => "Canada"
              :postal_code => "J4T 2V2", :user_id => 2,
              :delivery => 15, :latitude => 45.4914023, :longitude => -73.4684749

Category.create! :id => category++, :name => "Pizzas", :shop_id => shop
Product.create!  :id => product++, :name => "Marinara"
Size.create! :id => size++, :name => '12"', :category_id => category
Size.create! :id => size++, :name => '14"', :category_id => category
Size.create! :id => size++, :name => '16"', :category_id => category
Size.create! :id => size++, :name => '18"', :category_id => category

Item.create! :id => item++, :product_id => 

Category.create! :id => category++, :name => "Sandwichs", :shop_id => shop
Size.create! :id => size++, :name => '', :category_id => category

Category.create! :id => category++, :name => "Boissons", :shop_id => shop
Size.create! :name => '300ml', :category_id => 3
Size.create! :name => '2l', :category_id => 3

orientalis = Shop.create! :id => 1, :name => "Orientalis", :phone_number => "555-555-5555", 
              :city => "Saint-Hubert", :address => "4190 Grande Allée", :province => "QC", 
              :country => "Canada", :postal_code => "J4V 3N2", :user_id => 1, :minimum => 15, 
              :delivery => 30, :latitude => 45.4863035, :longitude => -73.4600382
