class Order < ActiveRecord::Base
  belongs_to :shop
  belongs_to :delivery_address
  delegate :user, :to => :delivery_address
  has_many :lines

  attr_accessible :delivery_address_id, :shop_id
  has_many :state_transitions, :class_name => "OrderStateTransition", :order => :created_at

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
      transition :call_pending => :calling do |order|
        order.ringing_at = Time.now.utc
      end
    end

    event :answer do
      transition :calling => :answered do |order|
        order.called_at = Time.now.utc
      end
    end

    before_transition OrderStateMachineObserver.method(:audit_order)
  end

  def self.find_all_by_user_id(*args)
    where( :delivery_address_id => DeliveryAddress.find_all_by_user_id(*args) ).all
  end

  def subtotal
    lines.inject(0) { |sum, line| sum + (line.item.price * line.quantity) }
  end
end
