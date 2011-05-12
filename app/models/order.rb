class Order < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user
  has_many :lines

  def subtotal
    lines.inject(0) { |sum, line| sum + (line.item.price * line.quantity) }
  end
end
