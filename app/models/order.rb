class Order < ActiveRecord::Base
  belongs_to :shop
  belongs_to :delivery_address
  delegate :user, :to => :delivery_address
  has_many :lines
  attr_accessible :delivery_address_id, :shop_id

  state_machine :initial => :pending do
    state :pending
    state :accepted
    state :refused

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
  end

  state_machine :call_state, :initial => :call_pending do
    state :call_pending
    state :called

    event :ring do
      transition :from => :call_pending, :to => :called
    end
  end

  def self.find_all_by_user_id(*args)
    where( :delivery_address_id => DeliveryAddress.find_all_by_user_id(*args) ).all
  end

  def subtotal
    lines.inject(0) { |sum, line| sum + (line.item.price * line.quantity) }
  end
end
