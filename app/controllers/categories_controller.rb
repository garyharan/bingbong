# coding: utf-8
class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @shop = current_user.shops.find(params[:shop_id])
    @category = @shop.categories.create(params[:category])

    redirect_to shop_path(@shop)
  end

  def update
    @shop = current_user.shops.find(params[:shop_id])
    @category = @shop.categories.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @shop, :notice => "Les changements ont été effectués." }
        format.js
      else
        format.html { redirect_to @shop }
        format.js
      end
    end
  end

  def destroy
    @shop = current_user.shops.find params[:shop_id]
    @category = @shop.categories.find params[:id]

    respond_to do |format|
      if @category.destroy
        format.html { redirect_to @shop, :notice => "La catégorie a été supprimé." }
      else
        format.html { redirect_to @shop, :error => "Impossible de supprimé cette catégorie." }
      end
    end
  end
end
