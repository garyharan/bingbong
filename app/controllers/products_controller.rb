# coding: utf-8
class ProductsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @category = Category.find params[:category_id]
    @product = @category.products.new params[:product]

    @product.save
    redirect_to shop_path(@category.shop)
  end

  def update
    @category = Category.find params[:category_id]
    @product = @category.products.find params[:id]

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.js
      else
        format.js { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @shop = current_user.shops.find params[:shop_id]
    @category = @shop.categories.find params[:category_id]
    @product = @category.products.find params[:id]

    respond_to do |format|
      if @product.destroy
        format.html { redirect_to shop_path(@shop), :notice => "Le produit a été supprimé." }
      else
        format.html { redirect_to shop_path(@shop), :error => "Impossible de supprimé ce produit." }
      end
    end
  end
end
