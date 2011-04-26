class ItemsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @category = Category.find params[:category_id]
    @item = @category.items.new params[:item]

    @item.save
  end
end
