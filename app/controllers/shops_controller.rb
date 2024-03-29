class ShopsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @shops = Shop.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @shop = Shop.find(params[:id])
    if user_signed_in?
      if params[:order_id]
        order = current_user.orders.find(params[:order_id])
        order.lines.each do |line|
          new_line = line.clone
          new_line.order_id = nil
          new_line.save!
        end
      end
      @lines = Line.find(:all, :conditions => { :shop_id => @shop.id, :client_id => current_user.id, :order_id => nil })

      # Need logic to calculate fees and such: can't put that in the view
      @order = Order.fake_from(@lines)
    end

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @shop = current_user.shops.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def create
    @shop = current_user.shops.new(params[:shop])

    respond_to do |format|
      if @shop.save
        format.html { redirect_to(@shop, :notice => 'Shop was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @shop = current_user.shops.find(params[:id])

    respond_to do |format|
      if @shop.update_attributes(params[:shop])
        format.html { redirect_to(@shop, :notice => 'Shop was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @shop = current_user.shops.find(params[:id])
    @shop.destroy

    respond_to do |format|
      format.html { redirect_to(shops_url) }
    end
  end
end
