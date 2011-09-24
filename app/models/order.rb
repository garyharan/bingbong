class Order < ActiveRecord::Base
  belongs_to :shop
  belongs_to :delivery_address
  delegate :client, :to => :delivery_address

  attr_accessible :delivery_address_id, :shop_id

  has_many :lines, :dependent => :delete_all
  has_many :state_transitions, :class_name => "OrderStateTransition", :order => :created_at, :dependent => :delete_all

  before_create do
    self.validation_code = Digest::SHA1.new.update("#{Time.now}#{rand()}").hexdigest
  end

  state_machine :initial => :pending do
    event :refuse do
      transition :pending => :refused do |order|
        order.refused_at = Time.now.utc
      end
    end

    event :accept do
      transition :pending => :accepted do |order|
        order.accepted_at = Time.now.utc
      end
    end

    before_transition OrderStateMachineObserver.method(:audit_order)
  end

  state_machine :call_state, :initial => :call_pending do
    before_transition :on => :ring, :do => :call
    event :ring do
      transition :call_pending => :calling
    end

    event :answer do
      transition :calling => :answered, :if => lambda {|order| order.accepted? || order.refused?}
      transition :calling => same
    end

    before_transition OrderStateMachineObserver.method(:audit_order)
  end

  def self.find_all_by_client_id(*args)
    where( :delivery_address_id => DeliveryAddress.find_all_by_client_id(*args) ).all
  end

  def subtotal_amount
    lines.inject(0) { |sum, line| sum + line.extension }
  end

  def delivery_fee_amount
    shop.delivery_fee_to(self)
  end

  def gst_subtotal
    [subtotal_amount, delivery_fee_amount].sum
  end

  def gst_amount
    val = gst_subtotal * shop.gst_rate * 100
    val = val.ceil
    val / 100.0
  end

  def pst_subtotal
    [subtotal_amount, delivery_fee_amount, gst_amount].sum
  end

  def pst_amount
    val = pst_subtotal * shop.pst_rate * 100
    val = val.ceil
    val / 100.0
  end

  def total_amount
    [subtotal_amount, delivery_fee_amount, gst_amount, pst_amount].sum
  end

  def self.fake_from(lines)
    return Order.new if lines.blank?

    Order.new do |order|
      order.shop = lines.first.shop
      order.lines.concat(lines)
      order.delivery_address = lines.first.client.delivery_addresses.first || DeliveryAddress.new
      order.readonly! # Musn't let the Order escape: the UI must really go through the #create operation, indicating intent
    end
  end

  def order_string
    lines.map do |line|
      "#{line.quantity} #{line.item.product.category.name}, #{line.item.size.order_name}, #{line.item.product.name}"
    end.join(";")
  end

  def call
    unless Rails.env.test?
      RestClient.post(TROPO_SESSION_API_URL, call_options.merge(
        :action => "create",
        :token  => TROPO_TOKEN_ID
      ))
    end
  end

  def call_options
    {
      :name      => delivery_address.client.name,
      :address   => delivery_address.address_string,
      :order_id  => id,
      :shop_id   => shop.id,
      :shop_name => shop.name,
      :number    => shop.phone_number,
      :orders    => order_string,
      :code      => validation_code
    }
  end
end
