class LinesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @line = Line.create params[:line].merge(:user_id => current_user.id)
  end
end
