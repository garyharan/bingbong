class Line < ActiveRecord::Base
  has_one :shop
  belongs_to :item
end
