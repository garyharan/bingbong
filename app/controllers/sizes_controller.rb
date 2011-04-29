class SizesController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @size = @category.sizes.create params[:size]

    redirect_to shop_path(@category.shop)
  end
end
