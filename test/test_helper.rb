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

module Geocoder
  module Lookup
    class Base
      private
      def read_fixture(file)
        File.read(File.join('test','fixtures', file)).gsub(/\n\s*/, '')
      end
    end

    class GeocoderCa < Base
      private
      def fetch_raw_data(query, reverse = false)
        raise TimeoutError if query == "timeout"
        raise SocketError if query == "socket_error"
        file = case query
          when "no results";   :no_results
          when "no locality";  :no_locality
          when "no city data"; :no_city_data
          else                 :madison_square_garden
        end
        read_fixture('geocoder_ca.json')
      end
    end
  end
end
