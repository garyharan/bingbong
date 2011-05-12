class OrdersController < ApplicationController
  def create
    @order = Order.create params[:order].merge(:user_id => current_user.id)
    Line.find(:all, :conditions => { :order_id => nil, :user_id => current_user.id, :shop_id => params[:order][:shop_id]}).each do |line|
      line.update_attribute :order_id, @order.id
    end
  end
end
