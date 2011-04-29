# coding: utf-8
class SizesController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @shop = @category.shop
    @size = @category.sizes.new params[:size]

    respond_to do |format|
      if @size.save
        format.html { redirect_to(@shop, :notice => 'Le nouveau format de taille a été sauvé.') }
      else
        format.html { redirect_to shop_path(@shop) }
      end
    end
  end
end
