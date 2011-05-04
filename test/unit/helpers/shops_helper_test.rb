require 'test_helper'

class ShopsHelperTest < ActionView::TestCase
  test "should create proper url" do
    @shop = Factory.build(:shop)
    @url = map_url(@shop)
    assert_equal @url, 'http://maps.google.com/maps/api/staticmap?size=170x140&zoom=13&markers=size:mid|color:0xE35524|1514+Murray+Street%2CSaint-Hubert%2CQuebec%2CJ4T1C7&sensor=false'
  end
end
