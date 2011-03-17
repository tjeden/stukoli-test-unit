require 'lib/average'
require 'test/unit'

class TestAverage < Test::Unit::TestCase

  def test_simple
    assert_equal 4.5, [4,5].average 
    assert_equal 3, [2,2,3,5].average 
  end

  def test_empty_array
    assert_nil [].average
  end

end
