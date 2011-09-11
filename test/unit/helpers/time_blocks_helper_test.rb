require 'test_helper'

class TimeBlocksHelperTest < ActionView::TestCase
  def test_weekday
    assert_equal "Lundi"    , human_weekday(1)
    assert_equal "Mardi"    , human_weekday(2)
    assert_equal "Mercredi" , human_weekday(3)
    assert_equal "Jeudi"    , human_weekday(4)
    assert_equal "Vendredi" , human_weekday(5)
    assert_equal "Samedi"   , human_weekday(6)
    assert_equal "Dimanche" , human_weekday(7)
  end
end
