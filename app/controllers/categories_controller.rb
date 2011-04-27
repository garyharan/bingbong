class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @shop = current_user.shops.find(params[:shop_id])
    @category = @shop.categories.new(params[:category])
    
    @category.save
  end

  def update
    @shop = current_user.shops.find(params[:shop_id])
    @category = @shop.categories.find(params[:id])

    @category.update_attributes(params[:category])
  end

  def destroy

  end
end
