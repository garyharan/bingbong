class Item < ActiveRecord::Base
  belongs_to :product
  belongs_to :size

  def name
    product.name
  end
end
