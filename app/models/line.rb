class Line < ActiveRecord::Base
  has_one :shop
  belongs_to :item

  default_scope :order => 'created_at ASC'
end
