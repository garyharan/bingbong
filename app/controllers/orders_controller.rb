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
    @current_address_id = current_user.orders.last.try(:delivery_address_id) || "new"
    @delivery_address = DeliveryAddress.new(:user_id => current_user.id, 
                                            :address => current_user.searches.last.try(:location), 
                                            :phone_number => DeliveryAddress.where(:user_id => current_user.id).order("updated_at desc").limit(1).first.try(:phone_number))
    @order = Order.new params[:order]
    @shop  = @order.shop
    @lines = Line.find(:all, :conditions => { :order_id => nil, :user_id => current_user.id, :shop_id => @order.shop_id })
  end

  def create
    begin
      Order.transaction do
        if params[:order][:delivery_address_id] == "new"
          @delivery_address = current_user.delivery_addresses.new(params[:delivery_address])
          @delivery_address.save!
          params[:order][:delivery_address_id] = @delivery_address.id
        end

        if DeliveryAddress.where(:id => params[:order][:delivery_address_id], :user_id => current_user.id).blank?
          flash[:notice] = "Mauvaise adresse, veuillez en choisir une nouvelle"
          raise
        else
          @order = Order.create params[:order] #.merge(:user_id => current_user.id)
          Line.find(:all, :conditions => { :order_id => nil, :user_id => current_user.id, :shop_id => params[:order][:shop_id]}).each do |line|
            line.update_attribute :order_id, @order.id
          end
          redirect_to @order
        end
      end
    rescue
      @current_address_id = params[:order][:delivery_address_id]
      if @delivery_address.nil?
        @delivery_address = DeliveryAddress.new(:user_id => current_user.id,
                                                :address => current_user.searches.last.try(:location), 
                                                :phone_number => DeliveryAddress.where(:user_id => current_user.id).order("updated_at desc").limit(1).first.try(:phone_number))
      end

      @order = Order.new params[:order] if @order.nil?
      @shop  = @order.shop if @shop.nil?
      @lines = Line.find(:all, :conditions => { :order_id => nil, :user_id => current_user.id, :shop_id => @order.shop_id }) if @lines.nil?

      render :action => "new"
    end
  end
end
