# coding : utf-8
class DeliveryAddressesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_delivery_address, :only => [:edit, :update, :destroy]

  def index
    @delivery_addresses = current_user.delivery_addresses

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @delivery_addresses }
    end
  end

  def new
    @delivery_address = DeliveryAddress.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @delivery_address }
    end
  end

  def edit
  end

  def create
    @delivery_address = current_user.delivery_addresses.new(params[:delivery_address])

    respond_to do |format|
      if @delivery_address.save
        format.html { redirect_to(:action => :index, :notice => 'Votre nouvelle adresse est enregistrée.') }
        format.xml  { render :xml => @delivery_address, :status => :created, :location => @delivery_address }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @delivery_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @delivery_address.update_attributes(params[:delivery_address])
        format.html { redirect_to(:action => :index, :notice => 'Votre adresse a été modifiée avec succès.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @delivery_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @delivery_address.destroy

    respond_to do |format|
      format.html { redirect_to(delivery_addresses_url) }
      format.xml  { head :ok }
    end
  end

  private

  def find_delivery_address
    @delivery_address = DeliveryAddress.where(:id => params[:id], :user_id => current_user.id).first
    if @delivery_address.nil?
      redirect_to :back, :error => "Désolé, l'adresse que vous voulez accéder ne vous appartient pas."
      return
    end
  end
end
