class Order < ActiveRecord::Base
  include ActiveRecord::Transitions

  belongs_to :shop
  belongs_to :delivery_address
  delegate :user, :to => :delivery_address
  has_many :lines

  state_machine do
    state :pending
    state :accepted
    state :refused

    event :refuse do
      transitions :to => :refused, :from => :pending, :on_transition => :do_refuse
    end

    event :accept do
      transitions :to => :accepted, :from => :pending, :on_transition => :do_accept
    end
  end

  def self.find_all_by_user_id(*args)
    where( :delivery_address_id => DeliveryAddress.find_all_by_user_id(*args) ).all
  end

  def subtotal
    lines.inject(0) { |sum, line| sum + (line.item.price * line.quantity) }
  end

  private

  def do_refuse(refused_at = Time.now)
    self.refused_at = refused_at
  end

  def do_accept(accepted_at = Time.now)
    self.accepted_at = accepted_at
  end
end
