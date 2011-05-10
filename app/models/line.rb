class Line < ActiveRecord::Base
  has_one :shop
  has_one :item
end
