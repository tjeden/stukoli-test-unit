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
* Dostarcza sposobów wywoływania testów

!SLIDE 

## Suche prezentacje są nudne ##

    git clone git@github.com:tjeden/stukoli-test-unit.git

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

