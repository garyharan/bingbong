# coding : utf-8
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

    @delivery_address.phone_number = "514-123-4567"
    assert @delivery_address.valid?, "Phone number : '514-123-4567' should be valid"

    @delivery_address.phone_number = "(514)123-4567"
    assert @delivery_address.valid?, "Phone number : '(514)123-4567' should be valid"

    @delivery_address.phone_number = "(514) 123-4567"
    assert @delivery_address.valid?, "Phone number : '(514) 123-4567' should be valid"

    @delivery_address.phone_number = "(514)1234567"
    assert @delivery_address.valid?, "Phone number : '(514)1234567' should be valid"

    @delivery_address.phone_number = "5141234567"
    assert @delivery_address.valid?, "Phone number : '5141234567' should be valid"
  end

  test "delivery address#formatted_phone_number" do
    @delivery_address.phone_number = "514-123-4567"
    assert_equal "(514) 123-4567", @delivery_address.formatted_phone_number

    @delivery_address.phone_number = "(514)1234567"
    assert_equal "(514) 123-4567", @delivery_address.formatted_phone_number

    @delivery_address.phone_number = "(514) 1234567"
    assert_equal "(514) 123-4567", @delivery_address.formatted_phone_number

    @delivery_address.phone_number = "(514)1234567"
    assert_equal "(514) 123-4567", @delivery_address.formatted_phone_number

    @delivery_address.phone_number = "5141234567"
    assert_equal "(514) 123-4567", @delivery_address.formatted_phone_number

    @delivery_address.phone_number = ""
    assert_equal "", @delivery_address.formatted_phone_number

    @delivery_address.phone_number = "invalid phone number"
    assert_equal "", @delivery_address.formatted_phone_number
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

  test "delivery_address#formatted_zip_code" do
    @delivery_address.zip_code = "H1W 3N5"
    assert_equal "H1W 3N5", @delivery_address.formatted_zip_code

    @delivery_address.zip_code = "H1W3N5"
    assert_equal "H1W 3N5", @delivery_address.formatted_zip_code

    @delivery_address.zip_code = "h1w 3n5"
    assert_equal "H1W 3N5", @delivery_address.formatted_zip_code

    @delivery_address.zip_code = "H1W 3n5"
    assert_equal "H1W 3N5", @delivery_address.formatted_zip_code

    @delivery_address.zip_code = "H1w3n5"
    assert_equal "H1W 3N5", @delivery_address.formatted_zip_code

    @delivery_address.zip_code = ""
    assert_equal "", @delivery_address.formatted_zip_code

    @delivery_address.zip_code = "invalid zip code"
    assert_equal "", @delivery_address.formatted_zip_code
  end

  test "#address_string" do
    assert_equal @delivery_address.address_string, "1234 Any road, appartement 1, A City, téléphone 1234567890, note, Knock 3 times"
  end

  test "#expanded_address" do
    assert_equal @delivery_address.expanded_address, "1234 Any road"
    @delivery_address.address = "1234 st-hubert"
    assert_equal @delivery_address.expanded_address, "1234 saint-hubert"
    @delivery_address.address = "1234 St-hubert"
    assert_equal @delivery_address.expanded_address, "1234 saint-hubert"
    @delivery_address.address = "1234 ST-hubert"
    assert_equal @delivery_address.expanded_address, "1234 saint-hubert"
    @delivery_address.address = "1234 Saint-hubert"
    assert_equal @delivery_address.expanded_address, "1234 Saint-hubert"
  end

  test "#expanded_city" do
    assert_equal @delivery_address.expanded_city, "A City"
    @delivery_address.city = "st-hubert"
    assert_equal @delivery_address.expanded_city, "saint-hubert"
    @delivery_address.city = "St-hubert"
    assert_equal @delivery_address.expanded_city, "saint-hubert"
    @delivery_address.city = "ST-hubert"
    assert_equal @delivery_address.expanded_city, "saint-hubert"
    @delivery_address.city = "Saint-hubert"
    assert_equal @delivery_address.expanded_city, "Saint-hubert"
  end
end
