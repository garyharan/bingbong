require 'test_helper'

class DeliveryAddressTest < ActiveSupport::TestCase
  setup do 
    @delivery_address = DeliveryAddress.new :address => "1514 Murray, St-Hubert", :apartment => nil, :phone_number => "555-555-5555", :note => nil
  end

  test "delivery address#phone_number is a valid phone number" do
    assert @delivery_address.valid?, "Default delivery address should be valid"

    @delivery_address.phone_number = "invalid_number"
    assert !@delivery_address.valid?, "Phone number : 'invalid_number' should be invalid"

    @delivery_address.phone_number = "123-4567"
    assert !@delivery_address.valid?, "Phone number : '123-4567' should be invalid"
  end
end
