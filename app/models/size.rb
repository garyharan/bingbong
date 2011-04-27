class Size < ActiveRecord::Base
  belongs_to :item

  validates_presence_of :price
end
