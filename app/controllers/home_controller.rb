class HomeController < ApplicationController
  def index
  end

  def find
    @coordinates = Geocoder.coordinates params[:address]
    @shops = Shop.near(@coordinates)
  end
end
