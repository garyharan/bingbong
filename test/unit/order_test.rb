require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "order subtotal should display proper price" do
     @order = Factory.create :order
     @item  = Factory.create :item
     3.times do
       Line.create Factory.attributes_for(:line, :order_id => @order.id, :item_id => @item.id)
     end
    assert_equal (Factory.build(:item).price * 3), (@order.subtotal) * 1.0
  end
end
