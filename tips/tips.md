!SLIDE

## Setup && Teardown ##

    @@@Ruby
    require "test/unit"
     
    class TestSimpleNumber < Test::Unit::TestCase
     
      def setup
        @num = SimpleNumber.new(2)
      end
       
      def teardown
        @num.delete
      end
       
      def test_simple
        assert_equal(4, @num.add(2) )
      end
       
      def test_simple2
        assert_equal(4, @num.multiply(2) )
      end
       
    end

!SLIDE

## Uruchamianie wybranego testu ##

    ruby test/test_average.rb --name test_empty_array

!SLIDE incremental center

## Alternatywy (4?):##

* Rspec 

!SLIDE incremental

## Czy to jest użyteczne?

* Tak. Ja korzystam.
* Testowanie logiki.
* Symulowanie działań użytkownika.
* Symulowanie przeglądarki (capybara, selenium).
* Co dusza zapragnie...

!SLIDE

# Ruby ♥ Tests #
