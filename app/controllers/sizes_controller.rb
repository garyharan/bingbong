# coding: utf-8
class SizesController < ApplicationController
   before_filter :authenticate_user!

  def create
    @category = Category.find(params[:category_id])
    @shop = @category.shop
    @size = @category.sizes.new params[:size]

    respond_to do |format|
      if @size.save
        format.html { redirect_to(@shop, :notice => 'Le nouveau format de taille a été enregistré.') }
      else
        format.html { redirect_to shop_path(@shop) }
      end
    end
  end

  def update
    @shop = current_user.shops.find(params[:shop_id])
    @category = @shop.categories.find(params[:category_id])
    @size = @category.sizes.find(params[:id])

    respond_to do |format|
      if @size.update_attributes(params[:size])
        format.json { head :ok }
      else
        format.json { render :json => @size.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @shop = current_user.shops.find params[:shop_id]
    @category = @shop.categories.find params[:category_id]
    @size = @category.sizes.find params[:id]

    @size.destroy

    redirect_to @shop
  end
end
