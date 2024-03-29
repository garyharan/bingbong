# coding : utf-8
class DeliveryAddressesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_delivery_address, :only => [:edit, :update, :destroy]

  def index
    @delivery_addresses = current_user.delivery_addresses.current
    @delivery_address = DeliveryAddress.new

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    @delivery_address = DeliveryAddress.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
  end

  def create
    @delivery_address = current_user.delivery_addresses.new(params[:delivery_address])

    respond_to do |format|
      if @delivery_address.save
        flash[:notice] = 'Votre nouvelle adresse est enregistrée.'
        format.js
      else
        format.js { render :errors }
      end
    end
  end

  def update
    respond_to do |format|
      if @delivery_address.update_attributes(params[:delivery_address])
        flash[:notice] = 'Votre adresse a été modifiée avec succès.'
        format.html { redirect_to :back }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @delivery_address.deleted = true
    @delivery_address.save!

    respond_to do |format|
      format.js
    end
  end

  private

  def find_delivery_address
    @delivery_address = current_user.delivery_addresses.current.find(params[:id])
    return if @delivery_address

    flash[:notice] = "Désolé, l'adresse que vous voulez accéder n'existe pas."
    redirect_to :back
  end
end
