class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @shop = current_user.shops.find(params[:shop_id])
    @category = @shop.categories.new(params[:category])
    
    respond_to do |format|
      if @category.save
        flash[:notice] = "Succesfully created category."
        format.js
      end
    end
  end

  def update

  end

  def destroy

  end
end
