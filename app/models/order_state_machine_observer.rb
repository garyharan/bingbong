class OrderStateMachineObserver

  # Audits changes to order states to the order_state_transitions table.
  def self.audit_order(order, transition)
    order.state_transitions.create!(
      :from   => transition.from,
      :to     => transition.to,
      :column => transition.attribute,
      :event  => transition.event)
  end

end
