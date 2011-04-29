class ItemsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @category = Category.find params[:category_id]
    @item = @category.items.new params[:item]

    @item.save
  end

  def update
    @category = Category.find params[:category_id]
    @item = @category.items.find params[:id]

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.json { head :ok }
      else
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end
end
