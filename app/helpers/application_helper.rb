module ApplicationHelper
  def error_messages_for(record)
    record.errors.full_messages.join('. ')
  end
end
