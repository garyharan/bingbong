require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do 
    @user = User.new :email => "gary.haran@grandmenu.com", :password => "my password", :first_name => "Gary", :last_name => "Haran", :delivery_address => Factory(:delivery_address).id
  end
  test "user#name returns full name" do
    assert_equal "Gary Haran", @user.name
  end

  test "user#admin? returns false by default" do
    assert_equal false, @user.admin?
  end
end
