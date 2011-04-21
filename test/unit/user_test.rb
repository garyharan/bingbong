require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user#name returns full name" do
    user = User.new :first_name => "Gary", :last_name => "Haran"
    assert_equal "Gary Haran", user.name
  end
end
