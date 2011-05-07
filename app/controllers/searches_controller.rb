class SearchesController < ApplicationController
  def index
    @search = Search.new
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
    @search = Search.find_by_location(params[:search][:location]) || Search.new(params[:search])

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search }
      else
        format.html { render :action => "new" }
      end
    end
  end
end