class Line < ActiveRecord::Base
  has_one :shop
  belongs_to :item
  belongs_to :order

  default_scope :order => 'created_at ASC'
end
