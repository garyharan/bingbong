class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = Order.find_all_by_client_id(current_user.id)
  end

  def show
    @order = Order.find params[:id]
    @lines = @order.lines
  end

  def new
    @current_address_id = current_user.orders.last.try(:delivery_address_id) || "new"
    @delivery_address = current_user.delivery_addresses.new(
                                            :address => current_user.searches.last.try(:location),
                                            :phone_number => current_user.delivery_addresses.current.order("updated_at DESC").first.try(:phone_number))
    @order = Order.new params[:order]
    @shop  = @order.shop
    @order.lines = Line.find(:all, :conditions => { :order_id => nil, :client_id => current_user.id, :shop_id => @order.shop_id })
  end

  def create
    begin
      Order.transaction do
        if params[:order][:delivery_address_id] == "new"
          @delivery_address = current_user.delivery_addresses.create!(params[:delivery_address])
          params[:order][:delivery_address_id] = @delivery_address.id
        end

        unless current_user.delivery_addresses.current.where(:id => params[:order][:delivery_address_id]).exists?
          flash.now[:notice] = "Mauvaise adresse, veuillez en choisir une nouvelle"
          raise "no good"
        end

        @order = Order.create params[:order] #.merge(:user_id => current_user.id)
        Line.update_all({:order_id => @order.id}, {:order_id => nil, :client_id => current_user.id, :shop_id => params[:order][:shop_id]})
      end
      @order.ring!

      redirect_to @order
    rescue
      logger.error { "#{$!.class}: #{$!.message}\n#{ $!.backtrace.join("\n") }" }
      @current_address_id = params[:order][:delivery_address_id]
      if @delivery_address.nil?
        @delivery_address = current_user.delivery_addresses.build(
                                                :address => current_user.searches.last.try(:location),
                                                :phone_number => current_user.delivery_addresses.current.order("updated_at DESC").first.try(:phone_number))
      end

      @order = Order.new params[:order] if @order.nil?
      @shop  = @order.shop if @shop.nil?
      @lines = Line.find(:all, :conditions => { :order_id => nil, :client_id => current_user.id, :shop_id => @order.shop_id }) if @lines.nil?

      render :action => "new"
    end
  end
end
