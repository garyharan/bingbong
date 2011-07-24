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
    delivery_address = current_user.orders.last.try(:delivery_address)
    if delivery_address.nil?
      # don't work
      delivery_address = DeliveryAddress.create(:user_id => current_user.id, 
                                               :address => current_user.searches.last.try(:location), 
                                               :phone_number => current_user.orders.last.try(:phone_number))
    end
    @order = Order.new params[:order].merge(:delivery_address => delivery_address)
    @shop  = @order.shop
    @lines = Line.find(:all, :conditions => { :order_id => nil, :user_id => current_user.id, :shop_id => @order.shop_id })
  end

  def create
    if DeliveryAddress.where(:id => params[:order][:delivery_address_id], :user_id => current_user.id).blank?
      flash[:notice] = "Mauvaise adresse, veuillez en choisir une nouvelle"
      redirect_to :action => :new, :order => params[:order]
    else
      @order = Order.create params[:order] #.merge(:user_id => current_user.id)
      Line.find(:all, :conditions => { :order_id => nil, :user_id => current_user.id, :shop_id => params[:order][:shop_id]}).each do |line|
        line.update_attribute :order_id, @order.id
      end
      redirect_to @order
    end
  end
end
