class PotentialsController < ApplicationController
  def show
    @potential = Potential.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @potential = Potential.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @potential = Potential.new(params[:potential])

    respond_to do |format|
      if @potential.save
        format.html { redirect_to(@potential) }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
