class Item < ActiveRecord::Base
  belongs_to :category
  has_many :sizes, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :category_id
end
