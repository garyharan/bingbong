require 'test_helper'

class LineTest < ActiveSupport::TestCase
  should belong_to(:item)
  should belong_to(:order)
  should belong_to(:client)
end
