require 'test_helper'

class SizeTest < ActiveSupport::TestCase
  test "only valid if we have a price" do
    assert Size.create.errors.any?
  end
end
