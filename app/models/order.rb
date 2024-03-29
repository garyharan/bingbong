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

  def gm_points
    @gm_points ||= calculate_gm_points
  end

  def calculate_gm_points(subtotal=subtotal_amount)
    if subtotal == 0
      0
    elsif subtotal < 20
      100
    else
      (((subtotal.to_f-15)/5).floor + 1) * 100
    end
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

    event :hungup do
      transition :calling => :call_pending
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
    s = lines.map do |line|
      "#{line.quantity} #{line.item.product.category.name}, #{line.item.size.order_name}, #{line.item.product.name}"
    end.join(";")
    unless s.blank?
      s.gsub!(/\bb\.?b\.?q\.?\b/i, 'barbekiou')
      s.gsub!(/burger\b/i, 'beurgueur')
    end
    s
  end

  def call(phone_number = nil)
    if Rails.env.production? || (phone_number.class == String || phone_number.class == Fixnum)
      options = call_options.merge(
        :action => "create",
        :token  => TROPO_TOKEN_ID
      )
      options[:number] = phone_number unless phone_number.blank? #For manual test

      RestClient.post(TROPO_SESSION_API_URL, options)
    end
  end

  def call_options
    {
      :name      => CGI::escape(delivery_address.client.name),
      :address   => CGI::escape(delivery_address.address_string),
      :order_id  => id,
      :shop_id   => shop.id,
      :shop_name => CGI::escape(shop.name),
      :number    => shop.phone_number,
      :orders    => CGI::escape(order_string),
      :code      => validation_code,
      :url       => TROPO_CALLBACK_ADDRESS
    }
  end
end
