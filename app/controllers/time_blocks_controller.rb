class TimeBlocksController < ApplicationController
  before_filter :find_shop

  # GET /time_blocks
  # GET /time_blocks.xml
  def index
    @time_blocks = @shop.time_blocks
  end

  # GET /time_blocks/1
  # GET /time_blocks/1.xml
  def show
    @time_block = TimeBlock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @time_block }
    end
  end

  # GET /time_blocks/new
  # GET /time_blocks/new.xml
  def new
    @time_block = TimeBlock.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @time_block }
    end
  end

  # GET /time_blocks/1/edit
  def edit
    @time_block = TimeBlock.find(params[:id])
  end

  # POST /time_blocks
  # POST /time_blocks.xml
  def create
    @time_block = @shop.time_blocks.new(params[:time_block])

    respond_to do |format|
      if @time_block.save
        format.html { redirect_to(shop_time_blocks_path, :notice => 'Time block was successfully created.') }
        format.xml  { render :xml => @time_block, :status => :created, :location => @time_block }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @time_block.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /time_blocks/1
  # PUT /time_blocks/1.xml
  def update
    @time_block = TimeBlock.find(params[:id])

    respond_to do |format|
      if @time_block.update_attributes(params[:time_block])
        format.html { redirect_to([@shop, @time_block], :notice => 'Time block was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @time_block.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /time_blocks/1
  # DELETE /time_blocks/1.xml
  def destroy
    @time_block = @shop.time_blocks.find(params[:id])
    @time_block.destroy

    respond_to do |format|
      format.html { redirect_to(shop_time_blocks_url) }
      format.xml  { head :ok }
    end
  end

  private
  def find_shop
    @shop = Shop.find params[:shop_id]
  end
end
