class Line < ActiveRecord::Base
  has_one :shop
  belongs_to :item
  belongs_to :order
  belongs_to :user

  default_scope :order => 'created_at ASC'
end
