class Line < ActiveRecord::Base
  has_one :shop
  belongs_to :item
  belongs_to :order
  belongs_to :client, :class_name => "User"

  default_scope :order => 'created_at ASC'

  validates_presence_of :shop_id, :item_id, :client_id
end
