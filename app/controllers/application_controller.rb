class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :debug
  # def debug
  #   flash[:alert] = "Vous devez confirmer votre compte pour continuer"
  #   flash[:notice] = "Vous etes bien beau aujourd'hui"
  # end
end
