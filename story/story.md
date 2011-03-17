!SLIDE incremental center

* Kto z was pisał kiedyś testy?
* Kto wie co to jest TDD?
* Kto z was programował z użyciem TDD?

!SLIDE incremental center

## "Dobry programista, wie czy napisał dobry kod. ##
## Po co pisać testy?" ##

!SLIDE center

I. Ruby to język interpretowany

!SLIDE center

II. Nikt nie jest idealny

!SLIDE center

III. Szybkie wyłapywanie błędów

!SLIDE center

IV. Pamięć jest zawodna

!SLIDE center

V. Łatwy refaktoring i zmiany

!SLIDE center

VI. Lepszy design kodu

!SLIDE center

VII. Test Driven Development

!SLIDE incremental bullets center

# TDD #

* Najpierw napisz test, który nie przejdzie
* Napisz kod, który przechodzi test
* Zrefaktoryzuj kod

!SLIDE

## Czym są testy? ##

    @@@Ruby
    require 'average'

    fail 'oczekiwane 4.5' if [4,5].average != 4.5
    fail 'oczekiwane 3' if [2,2,3,5].average != 3
    
!SLIDE incremental

## Co daje Test::Unit? ##

* Pozwala opisywać testy
* Pozwala tworzyć struktury testów
* Dostarcza spsobów wywoływania testów

!SLIDE 

### Przygotowujemy test ###

    @@@Ruby
    require 'lib/average'
    require 'test/unit'

    class TestAverage < Test::Unit::TestCase

      def test_simple
        assert_equal '4,5', [4,5].average 
        assert_equal '3', [2,2,3,5].average 
      end

    end

!SLIDE

### Wywołanie ###

    ruby test/test_average.rb

!SLIDE 

### Rezultat ###

    Loaded suite test/test_average
    Started
    E
    Finished in 0.000278 seconds.

      1) Error:
    test_simple(TestAverage):
    NoMethodError: undefined method `average' for [4, 5]:Array
        test/test_average.rb:5:in `test_simple'

    1 tests, 0 assertions, 0 failures, 1 errors

!SLIDE

### Dodanie metody average ###

    @@@Ruby
    class Array

      def average;
      end

    end

!SLIDE

### Rezultat ###

    Loaded suite test/test_average
    Started
    F
    Finished in 0.024466 seconds.

      1) Failure:
    test_simple(TestAverage) [test/test_average.rb:6]:
    <"4,5"> expected but was
    <nil>.

    1 tests, 1 assertions, 1 failures, 0 errors


!SLIDE

### Implementacja średniej (poprawna?)###

    @@@Ruby
    class Array

      def average
        sum = 0
        count = 0
        self.each do |element|
          sum += element
          count += 1
        end
        sum/count
      end

    end

!SLIDE 

### Rezultat ###

    Loaded suite test/test_average
    Started
    F
    Finished in 0.004176 seconds.

    1) Failure:
    test_simple(TestAverage) [test/test_average.rb:7]:
    <"4,5"> expected but was
    <4>.

!SLIDE

### Uwzględnienie poprawki ###

    @@@Ruby
    class Array

      def average
        sum = 0
        count = 0
        self.each do |element|
          sum += element
          count += 1
        end
        sum.to_f/count
      end

    end

!SLIDE

### Rezultat ###

    Loaded suite test/test_average
    Started
    F
    Finished in 0.004232 seconds.

    1) Failure:
    test_simple(TestAverage) [test/test_average.rb:7]:
    <"4,5"> expected but was
    <4.5>.

    1 tests, 1 assertions, 1 failures, 0 errors

!SLIDE

### Test jest do poprawienia ###

    @@@Ruby
    require 'lib/average'
    require 'test/unit'

    class TestAverage < Test::Unit::TestCase

      def test_simple
        assert_equal 4.5, [4,5].average 
        assert_equal 3, [2,2,3,5].average 
      end

    end

!SLIDE

### Rezultat ###

    Loaded suite test/test_average
    Started
    .
    Finished in 0.000239 seconds.

    1 tests, 2 assertions, 0 failures, 0 errors

!SLIDE

### Ciekawszy przypadek ###

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

    end

!SLIDE

### Rezultat ###

    Loaded suite test/test_average
    Started
    F.
    Finished in 0.00441 seconds.

    1) Failure:
    test_empty_array(TestAverage) [test/test_average.rb:12]:
    <nil> expected but was
    <NaN>.

    2 tests, 3 assertions, 1 failures, 0 errors

!SLIDE

### Pamiętaj cholero, nie dziel przez zero! ###
    @@@Ruby
    class Array

      def average
        sum = 0
        count = 0
        each do |element|
          sum += element
          count += 1
        end
        sum.to_f/count if count != 0
      end

    end

!SLIDE

### Rezultat ###

    Loaded suite test/test_average
    Started
    ..
    Finished in 0.000383 seconds.

    2 tests, 3 assertions, 0 failures, 0 errors

!SLIDE

### Refactoring? ###

    @@@Ruby
    class Array

      def average
        sum = 0
        count = 0
        each do |element|
          sum += element
          count += 1
        end
        sum.to_f/count if count != 0
      end

    end

    class Array

      def average
        sum = 0
        each do |element|
          sum += element
        end
        sum.to_f/size unless size == 0
      end

    end

!SLIDE

### Rezultat ###

    Loaded suite test/test_average
    Started
    ..
    Finished in 0.000383 seconds.

    2 tests, 3 assertions, 0 failures, 0 errors

!SLIDE

### Czy można to jeszcze skrócić? ###

    @@@Ruby
    class Array

      def average
        sum = 0
        each do |element|
          sum += element
        end
        sum.to_f/size unless size == 0
      end

    end

!SLIDE

### Czy można to jeszcze skrócić? ###

    @@@Ruby
    class Array

      def average
        inject{ |sum, element| sum + element }.to_f / size unless size == 0
      end

    end

!SLIDE

### Rezultat ###

    Loaded suite test/test_average
    Started
    ..
    Finished in 0.000383 seconds.

    2 tests, 3 assertions, 0 failures, 0 errors

!SLIDE

### Jeszcze bardziej? ###

    @@@Ruby
    class Array

      def average
        inject{ |sum, element| sum + element }.to_f / size unless size == 0
      end

    end

!SLIDE

### Jeszcze bardziej? ###
    @@@Ruby
    class Array

      def average
        inject(:+).to_f / size unless size == 0
      end

    end

!SLIDE

### Rezultat ###

    Loaded suite test/test_average
    Started
    ..
    Finished in 0.000312 seconds.

    2 tests, 3 assertions, 0 failures, 0 errors

!SLIDE incremental bullets center

# TDD #

* Najpierw napisz test, który nie przejdzie
* Napisz kod, który przechodzi test
* Zrefaktoryzuj kod

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

### Asercje ##

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

### Asercje ###

    @@@Ruby
    assert 2 > 0           #=> true 
    assert 0 > 2           #=> false

    assert_nil nil         #=> true
    assert_nil Cat.new     #=> false
    assert_not_nil Cat.new #=> true

!SLIDE

### Asercje ###

    @@@Ruby
    assert_not_equal(5, 3)     #=> true
    assert_equal(5, 3)         #=> false

    assert_in_delta(5, 4, 0.5) #=> false
    assert_in_delta(5, 4, 2.5) #=> true

!SLIDE

### Asercje ###

    @@@Ruby
    assert_nothing_raised Array.new #=> true
    assert_raise Array.ugabuga      #=> true

    a = Array.new

    assert_instance_of(Array, a)    #=> true
    assert_kind_of(Object, a)   #=> true
    assert_kind_of(Cat, a)          #=> false

!SLIDE

### Asercje ###
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

## [https://github.com/tjeden/topserver](https://github.com/tjeden/topserver) ##
