class ShopsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @shops = Shop.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shops }
    end
  end

  def show
    @shop = Shop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shop }
    end
  end

  def new
    @shop = current_user.shops.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shop }
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
        format.xml  { render :xml => @shop, :status => :created, :location => @shop }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shop.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @shop = current_user.shops.find(params[:id])

    respond_to do |format|
      if @shop.update_attributes(params[:shop])
        format.html { redirect_to(@shop, :notice => 'Shop was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shop.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @shop = current_user.shops.find(params[:id])
    @shop.destroy

    respond_to do |format|
      format.html { redirect_to(shops_url) }
      format.xml  { head :ok }
    end
  end
end
