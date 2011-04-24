class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @shop = current_user.shops.find(params[:shop_id])
    @category = @shop.categories.new(params[:category])
    
    if @category.save
      flash[:notice] = "Succesfully created category."
    end
  end

  def update
    
  end

  def destroy
    
  end
end
