class SearchesController < ApplicationController
  def index
    @search = Search.new
    if user_signed_in?
      @searches = current_user.searches
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
    @location = params[:location] || params[:search][:location]
    @search = Search.find_by_location(@location) || Search.new(params[:search])

    @search.user_id = current_user.id if user_signed_in?

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
