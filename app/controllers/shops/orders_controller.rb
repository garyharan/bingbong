# encoding: utf-8

class Shops::OrdersController < ApplicationController
  before_filter :authenticate_user!, :except => [:tropo_answer]

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

  def tropo_answer
    success = false
    order = Shop.find(params[:shop_id]).orders.find(params[:id])
    if params[:code] == order.validation_code
      case params[:result]
      when "accept"
        order.accept!
        order.answer!
        success = true
      when "refuse"
        order.refuse!
        order.answer!
        success = true
      else
        log_call_error "Unknown result : #{params[:result]}"
      end
    else
      log_call_error "Bad validation code"
    end

    if success
      render :status => 200, :text => ""
    else
      render :status => 400, :text => ""
    end
  end

  private
  def log_call_error(error)
    Rails.logger.error "CALL MESSAGE ERROR : #{error}"
  end
end
