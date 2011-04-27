class SizesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @item = Item.find params[:item_id]
    @size = @item.sizes.create params[:size]
  end
end
