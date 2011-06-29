# encoding: utf-8

class Shops::OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @shop   = Shop.find(params[:shop_id])
    @orders = @shop.orders.order("created_at DESC")
  end

  def accept
    order = Shop.find(params[:shop_id]).orders.find(params[:id])
    order.accept!

    flash[:notice] = "Vous avez accepté la commande"
    redirect_to :action => :index
  end

  def refuse
    order = Shop.find(params[:shop_id]).orders.find(params[:id])
    order.refuse!

    flash[:notice] = "Vous avez refusé la commande"
    redirect_to :action => :index
  end
end
