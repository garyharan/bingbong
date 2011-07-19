class OrderStateTransition < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :order, :from, :to, :column, :event
end
