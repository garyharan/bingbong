require 'test_helper'

class OrderStateTransitionTest < ActiveSupport::TestCase

  should validate_presence_of(:order)
  should validate_presence_of(:column)
  should validate_presence_of(:from)
  should validate_presence_of(:to)
  should validate_presence_of(:event)

  should belong_to(:order)

end
