require 'test_helper'

class DeliveryAddressTest < ActiveSupport::TestCase
  setup do
    @delivery_address = Factory(:delivery_address)
  end

  test "default delivery address is valid" do
    assert @delivery_address.valid?, "Default delivery address should be valid"
  end

  test "delivery address#phone_number is a valid phone number" do
    @delivery_address.phone_number = "invalid_number"
    assert !@delivery_address.valid?, "Phone number : 'invalid_number' should be invalid"

    @delivery_address.phone_number = "123-4567"
    assert !@delivery_address.valid?, "Phone number : '123-4567' should be invalid"
  end

  test "delivery address#zip_code is a valid zip code" do
    @delivery_address.zip_code = "invalid_zip_code"
    assert !@delivery_address.valid?, "Zip code : 'invalid_zip_code' should be invalid"

    @delivery_address.zip_code = "abc def"
    assert !@delivery_address.valid?, "Zip code : 'abc def' should be invalid"

    @delivery_address.zip_code = "h1w 3n5"
    assert @delivery_address.valid?, "Zip code : 'h1w 3n5' should be valid"

    @delivery_address.zip_code = "H1W 3N5"
    assert @delivery_address.valid?, "Zip code : 'H1W 3N5' should be valid"
  end
end
