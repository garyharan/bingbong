class PotentialsController < ApplicationController
  def index
    @potentials = Potential.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

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

  def edit
    @potential = Potential.find(params[:id])
  end

  def create
    @potential = Potential.new(params[:potential])

    respond_to do |format|
      if @potential.save
        format.html { redirect_to(@potential, :notice => 'Potential was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @potential = Potential.find(params[:id])

    respond_to do |format|
      if @potential.update_attributes(params[:potential])
        format.html { redirect_to(@potential, :notice => 'Potential was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @potential = Potential.find(params[:id])
    @potential.destroy

    respond_to do |format|
      format.html { redirect_to(potentials_url) }
    end
  end
end
