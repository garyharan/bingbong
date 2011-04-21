ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'factory_girl_rails'

Dir[Rails.root.join("factories/*.rb")].each { |f| require f }

class ActionController::TestCase
  include Devise::TestHelpers
end

