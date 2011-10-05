require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  should have_many(:state_transitions)

  setup do
    @shop = Factory.create(:shop)
    @order  = Factory.create(:order, :shop => @shop)
    @client = Factory.create(:client)
    @order.delivery_address.client = @client
    @items  = []
    3.times do
      @items << Factory.create(:item)
    end
    3.times do |i|
      @order.lines.create!( :item => @items[i], :shop_id => @shop.id, :client => @client )
    end
  end

  test "order subtotal_amount should display proper price" do
    assert_equal (Factory.build(:item).price * 3), (@order.subtotal_amount) * 1.0
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

  test "should transition :call_state to answered when the order is refused" do
    @order.ring!
    @order.refuse!
    @order.answer!
    expected = {"calling" => "answered"}
    assert_equal expected, @order.state_transitions.map{|st| {st.from => st.to}}.last
  end

  test "should transition :call_state to answered when the order is accepted" do
    @order.ring!
    @order.accept!
    @order.answer!
    expected = {"calling" => "answered"}
    assert_equal expected, @order.state_transitions.map{|st| {st.from => st.to}}.last
  end

  test "should transition call_state to calling again when answer didn't #accept!" do
    @order.ring!
    # No calls to #accept!
    @order.answer!
    expected = {"calling" => "calling"}
    assert_equal expected, @order.state_transitions.map{|st| {st.from => st.to}}.last
  end

  test "should transition call_state to calling again when answer didn't #refuse!" do
    @order.ring!
    # No calls to #refuse!
    @order.answer!
    expected = {"calling" => "calling"}
    assert_equal expected, @order.state_transitions.map{|st| {st.from => st.to}}.last
  end

  test "should build the order string" do
    # I don't like that test since I cannot control FactoryGirl sequence
    @order.lines.each_with_index do |line, index|
      line.quantity = index + 1
    end

    expected = ""
    @items.each_with_index do |item, index|
      expected << "#{index + 1} #{item.product.category.name}, #{item.size.order_name}, #{item.product.name};"
    end
    expected = expected[0..-2]

    assert_equal expected, @order.order_string
  end

  test "#call_options should return options for Tropo" do
    expected = {
      :name      => @client.name,
      :address   => @order.delivery_address.address_string,
      :order_id  => @order.id,
      :shop_id   => @shop.id,
      :shop_name => @shop.name,
      :number    => @shop.phone_number,
      :orders    => @order.order_string,
      :code      => @order.validation_code,
      :url       => "http://grandmenu.com"
    }
    assert_equal expected, @order.call_options

  end
end
