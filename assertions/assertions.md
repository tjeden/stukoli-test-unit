!SLIDE

### Struktura testów ###

    @@@Ruby
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

      def helper_metod
        #never goes here
      end

    end

!SLIDE

### Asercje (0/8)##

    @@@Ruby
    assert
    assert_nil
    assert_not_nil

    assert_not_equal
    assert_equal
    assert_in_delta

    assert_nothing_raised
    assert_raise
    assert_instance_of
    assert_kind_of
    assert_respond_to

    assert_no_math
    assert_match
    assert_same
    assert_not_same

    assert_operator
    assert_throws
    assert_send

    flunk

!SLIDE

### Asercje (1/8)###

    @@@Ruby
    assert 2 > 0                    #=> pass 
    assert 0 > 2                    #=> fail

    assert_nil nil                  #=> pass
    assert_nil Cat.new              #=> fail
    assert_not_nil Cat.new          #=> pass

!SLIDE

### Asercje (2/8)###

    @@@Ruby
    assert_not_equal(5, 3)          #=> pass  
    assert_equal(5, 3)              #=> fail

    assert_equal(5, 5.0)            #=> pass  (z użyciem == )
    assert_same(5, 5.0)             #=> fail (z użyciem eql?)
    assert_not_same(5, 5.0)         #=> pass

!SLIDE

### Asercje (3/8)###

    @@@Ruby
    assert_in_delta(5, 4, 0.5)      #=> fail
    assert_in_delta(5, 4, 2.5)      #=> pass

!SLIDE

### Asercje (4/8)###

    @@@Ruby
    assert_nothing_raised Array.new #=> pass
    assert_raise Array.ugabuga      #=> pass

    a = Array.new

    assert_instance_of(Array, a)    #=> pass
    assert_kind_of(Object, a)       #=> pass
    assert_kind_of(Cat, a)          #=> fail

!SLIDE

### Asercje (5/8)###

    @@@Ruby
    cat = Cat.new
    assert_respond_to(cat, :meow)   #=> pass

    dog = Dog.new
    assert_respond_to(dog, :meow)   #=> fail

!SLIDE

### Asercje (6/8)###

    @@@Ruby
    assert_no_math('02-770', /dd-ddd/) #=> fail
    assert_math('02-770', /dd-ddd/)    #=> pass

    assert_operator 5, :>, 4           #=> pass
    assert_operator 2, :>=, 2          #=> pass

!SLIDE

### Asercje (7/8)###

    @@@Ruby
    assert_throws :done do            #=> pass
      throw :done
    end

    assert_throws :done do            #=> fail
      throw :other_symbol
    end

!SLIDE

### Asercje (8/8)###

    @@@Ruby
    assert_send [[1, 2], :include?, 4] #=> fail
    assert_send [[1, 2], :include?, 2] #=> true

    flunk                              #=> fail (zawsze oblany)
