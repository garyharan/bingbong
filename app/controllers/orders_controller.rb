class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = Order.find_all_by_user_id(current_user.id)
  end

  def show
    @order = Order.find params[:id]
    @lines = @order.lines
  end

  def new
    @order = Order.new params[:order].merge(:user_id => current_user.id)
    @shop  = @order.shop
    @lines = Line.find(:all, :conditions => { :order_id => nil, :user_id => current_user.id, :shop_id => params[:order][:shop_id] })
  end

  def create
    @order = Order.create params[:order].merge(:user_id => current_user.id)
    Line.find(:all, :conditions => { :order_id => nil, :user_id => current_user.id, :shop_id => params[:order][:shop_id]}).each do |line|
      line.update_attribute :order_id, @order.id
    end
    redirect_to @order
  end
end
