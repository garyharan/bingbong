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

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.json { head :ok }
      else
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy

  end
end
