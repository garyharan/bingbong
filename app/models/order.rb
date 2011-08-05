class Order < ActiveRecord::Base
  belongs_to :shop
  belongs_to :delivery_address
  delegate :client, :to => :delivery_address

  attr_accessible :delivery_address_id, :shop_id

  has_many :lines, :dependent => :delete_all
  has_many :state_transitions, :class_name => "OrderStateTransition", :order => :created_at, :dependent => :delete_all

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

  def subtotal
    lines.inject(0) { |sum, line| sum + (line.item.price * line.quantity) }
  end
end
