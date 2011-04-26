require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "names are unique within each shop" do
    shop   = Shop.create Factory.attributes_for(:shop)
    pizzas_1 = Category.create :name => "Pizzas", :shop_id => shop.id
    pizzas_2 = Category.create :name => "Pizzas", :shop_id => shop.id
    assert pizzas_1.valid?
    assert !pizzas_2.valid?
  end

  test "name cannot be empty" do
    assert !Category.create.valid?, "Name cannot be empty."
  end
end
