require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  should belong_to(:shop)
  should have_many(:sizes)
  should have_many(:products)

  should validate_presence_of(:name)
  # FIXME: Make this validation pass
  # should validate_uniqueness_of(:name).scoped_to(:shop_id)

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
  
  test "when a category is destroyed all product, sizes and items should be destroyed as well" do
    Product.destroy_all
    Size.destroy_all
    Item.destroy_all
    @shop     = Shop.create Factory.attributes_for(:shop)
    @category = Category.create Factory.attributes_for(:category, :shop_id   => @shop.id)
    @product  = Product.create Factory.attributes_for(:product, :category_id => @category.id)
    @size     = Size.create Factory.attributes_for(:size, :category_id       => @category.id)
    
    assert_difference 'Category.count', -1 do
      assert_difference 'Product.count', -1 do
        assert_difference 'Size.count', -1 do
          assert_difference 'Item.count', -1 do
            @category.destroy
          end
        end
      end
    end
  end
end
