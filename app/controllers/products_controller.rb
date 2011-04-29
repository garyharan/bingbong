class ProductsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @category = Category.find params[:category_id]
    @product = @category.products.new params[:product]

    @product.save
  end

  def update
    @category = Category.find params[:category_id]
    @product = @category.products.find params[:id]

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.json { head :ok }
      else
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
end
