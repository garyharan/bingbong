class LinesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @shop = Shop.find(params[:line][:shop_id])
    @item = Item.find(params[:line][:item_id])

    if @line = Line.first(:conditions => { :client_id => current_user.id, :shop_id => @shop.id, :item_id => @item.id, :order_id => nil })
      @line.quantity += 1
      @line.save!
    else
      @line = Line.create params[:line].merge(:client_id => current_user.id)
    end

    @lines = Line.find(:all, :conditions => { :client_id => current_user.id, :shop_id => @shop.id, :order_id => nil })

    # Need logic to calculate fees and such: can't put that in the view
    @order = Order.fake_from(@lines)
  end

  def update
    @line = current_user.lines.find(params[:id])
    @shop = @line.shop
    @line.update_attributes params[:line]
    @line.destroy if @line.quantity == 0

    @lines = Line.find(:all, :conditions => { :client_id => current_user.id, :shop_id => @shop.id, :order_id => nil })

    # Need logic to calculate fees and such: can't put that in the view
    @order = Order.fake_from(@lines)
  end
end
