class Shops::OrdersController < ApplicationController
  before_filter :authenticate_user!
  def index
    @shop   = Shop.find(params[:shop_id])
    @orders = Order.find(:all, :conditions => { :shop_id => @shop.id })
  end
end
