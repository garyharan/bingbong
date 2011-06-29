ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'factory_girl_rails'

begin
  require "ruby-debug"
rescue LoadError
  # NOP - ignore
end

Dir[Rails.root.join("factories/*.rb")].each { |f| require f }

class ActionController::TestCase
  include Devise::TestHelpers
  include RR::Adapters::TestUnit
end

class ActiveSupport::TestCase
  include RR::Adapters::TestUnit
end
