# coding: utf-8
class DemosController < ApplicationController

  before_filter :assign_order

  def show
    render
  end

  def update
    RestClient.post(TROPO_SESSION_API_URL,
                    :action => "create",
                    :token  => TROPO_TOKEN_ID,
                    :name   => @name,
                    :number => @number.gsub(/\D/, ""),
                    :order  => @order)

    # Remember for next time around
    session[:demo_name]   = @name
    session[:demo_number] = @number
    session[:demo_order]  = @order

    redirect_to demo_url, :notice => "La commande est passée"
  end

  private

  def assign_order
    @name   = params[:name]   || session[:demo_name]   || "Gary"
    @number = params[:number] || session[:demo_number] || "(514) 909-4947"
    @order  = params[:order]  || session[:demo_order]  || "1 pizza pepperoni, large. 1 frite, sans-sel. 3 coca-cola. 1 pepsi max."
  end

end
