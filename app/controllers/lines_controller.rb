class LinesController < ApplicationController
  before_filter :authenticate_user!

  def create
    Line.create :user_id => current_user.id, :shop_id => params[:shop_id], :item_id => params[:item_id]
  end
end
