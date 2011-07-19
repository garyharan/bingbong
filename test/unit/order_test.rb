require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  should have_many(:state_transitions)

  setup do
    @order = Factory.create :order
    @item  = Factory.create :item
    3.times do
      Line.create Factory.attributes_for(:line, :order_id => @order.id, :item_id => @item.id)
    end
  end

  test "order subtotal should display proper price" do
    assert_equal (Factory.build(:item).price * 3), (@order.subtotal) * 1.0
  end

  test "should allow for refusal of order" do
    @order.refuse!
    assert_equal 'refused', @order.state
    assert_not_nil :refused_at
  end

  test "should allow for acceptance of order" do
    @order.accept!
    assert_equal 'accepted', @order.state
    assert_not_nil :accepted_at
  end

  test "should transition call_state when ringing" do
    @order.ring!
    assert_equal "calling", @order.call_state
  end

  test "should create an order_state_transition record when ringing" do
    @order.ring!
    assert_equal [{"call_pending" => "calling"}], @order.state_transitions.map{|st| {st.from => st.to}}
  end

  test "should create an order_state_transition record when answering the call" do
    @order.ring!
    @order.answer!
    expected = {"calling" => "answered"}
    assert_equal expected, @order.state_transitions.map{|st| {st.from => st.to}}.last
  end
end
