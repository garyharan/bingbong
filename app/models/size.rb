class Size < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  belongs_to :category
  has_many :products, :through => :items

  after_create :create_items
  def create_items
    category.products.each do |product|
      Item.create :product_id => product.id, :size_id => id
    end
  end

  before_destroy :destroy_related_items
  def destroy_related_items
    Item.destroy_all :size_id => id
  end

  def order_name
    @order_name ||= name.gsub(/(\d+)\s*(['"])/) do |match|
      case $2
        when "'"
          pluralize($1, "pied")
        when '"'
          pluralize($1, "pouce")
      end
    end
  end
end
