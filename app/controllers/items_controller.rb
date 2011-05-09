class ItemsController < ApplicationController
  before_filter :authenticate_user!
  
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.js
      else
        format.js { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end
end
