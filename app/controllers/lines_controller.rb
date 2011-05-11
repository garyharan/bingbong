class LinesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @shop_id = params[:line][:shop_id]
    @item_id = params[:line][:item_id]

    if @line = Line.first(:conditions => { :user_id => current_user.id, :shop_id => @shop_id, :item_id => @item_id })
      @line.quantity += 1
      @line.save!
    else
      @line = Line.create params[:line].merge(:user_id => current_user.id)
    end

    @lines = Line.find(:all, :conditions => { :user_id => current_user.id, :shop_id => @shop_id, :item_id => @item_id })
  end
end
