class SearchesController < ApplicationController
  before_filter :authenticate_user!, :only => :destroy

  def index
    @search = Search.new
    if user_signed_in?
      @delivery_addresses = current_user.delivery_addresses.limit(5).order("updated_at DESC").current
    end
  end

  def show
    @search = Search.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @search = Search.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @location = params[:search][:location]
    if user_signed_in?
      @search = current_user.searches.find_by_location(@location) || current_user.searches.new(params[:search])
    else
      @search = Search.find_by_location(@location) || Search.new(params[:search])
    end

    @search.client = current_user if user_signed_in?

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search }
      else
        format.html { render :action => "new" }
      end
    end
  rescue
    respond_to do |format|
      format.html { redirect_to @search }
    end
  end

  def destroy
    @search = current_user.searches.find params[:id]
    @search.destroy
    redirect_to searches_path
  end
end
