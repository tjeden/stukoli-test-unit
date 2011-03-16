!SLIDE incremental center

## Platforma do obliczeń rozproszonych z wykorzystaniem akceleratorów sprzętowych ##
* ## ..to proste ##
* ## tylko ##
 
!SLIDE center incremental 

## Co to są akceleratory sprzętowe? ##

!SLIDE center incremental

## To np. takie płytki ##

![Akcelerator](akcelerator.jpg)

* ### a właściwie układy ###

!SLIDE bullets incremental

## Plan: ##

* 1.Połączmy je w równoległą sieć 

* 2.Podzielmy obliczenia 

* 3.???? 

* 4.PROFIT!!! 

!SLIDE full-page

![Schemat](schemat.png)

!SLIDE full-page

![Komunikacja](komunikacja.png)

!SLIDE full-page

![Komunikacja](komunikacja2.png)

!SLIDE full-page

![Sinatra](frank_sinatra.jpg)

!SLIDE 

## Inicjalizacja ##

    @@@ Ruby
    EventMachine.run {
      EM.start_server 127.0.0.1, 6969, Listener 
    }

!SLIDE 

## Listener ##

    @@@ Ruby
    class Listener < EM::Connection

      def post_init; end

      def receive_data(data)
        send_data "OK"
      end

      def unbind; end
    end

!SLIDE

## Serwer ##

    @@@ Ruby 
    class Server
      def parse(data)
        ...
      end
    end

!SLIDE

## Listener ##

    @@@ Ruby
    class Listener < EM::Connection

      attr_accessor :server

      def post_init; end

      def receive_data(data)
        if @server.parse(data)
          send_data "OK"
        else
          send_data "ERROR"
        end
      end

      def unbind; end
    end

!SLIDE smaller

    @@@ Ruby
    EventMachine.run {
      EM.start_server 127.0.0.1, 6969, Listener do |listener|
        listener.server = server
      end
    }


!SLIDE full-page

![xkcd](xkcd.png)

!SLIDE 

## Event-driven I/O using the reactor pattern ##

!SLIDE  bullets incremental

## Co to jest reaktor? ##

    @@@ Ruby
    while reactor_running?
      do_something
    end
    
* Kod *Reaguje* na nadchodzące zdarzenia 

!SLIDE

## Najprostszy przykład ##

    @@@ Ruby
    require 'rubygems'
    require 'eventmachine'

    EventMachine.run {
      EventMachine.add_periodic_timer(1) {
        puts "Hello world"
      }
    }
    
!SLIDE

## Jak działa reaktor? ##

    @@@ Ruby
    EM.run {
      puts 'No i wystartowali'
    }
    
    puts 'To się nie wydarzy'
    
!SLIDE

## Jak go powstrzymać? ##

    @@@ Ruby
    EM.run {
      puts 'No i wystartowali'
      EM.stop
    }

    puts 'To się wydarzy'
    
!SLIDE

    @@@ Ruby
    EventMachine.run {
      server = Server.new
      server.log "Top server started" 
      EM::PeriodicTimer.new(0.25) do
        server.send_tasks_to_clients
      end
      EM::PeriodicTimer.new(1) do
        server.check_timeouts
      end
      EM::PeriodicTimer.new(2) do
        server.close_tasks
      end
      EM.start_server opts[:ip], opts[:port], Listener do |listener|
        listener.server = server
      end
    }
    
!SLIDE smaller

## Klient ##

    @@@ Ruby
    class Registerer < EM::Connection
      attr_accessor :ip, :port

      def initialize(ip, port)
        @ip = ip
        @port = port
      end

      def post_init
        send_data "REGISTER #{@ip} #{@port} foo"
      end

      def receive_data(data)
        puts "Registered with number: #{data}"
        close_connection
        EM.start_server(@ip, @port, ClientListener, data)
      end
    end
    
    EM.run{
      puts 'Registering client on server'
      EM.connect('0.0.0.0', 5555, Registerer, opts[:ip], opts[:port]) 
    }
    
!SLIDE

## [http://rubyeventmachine.com/](http://rubyeventmachine.com/) ##

## [https://github.com/tjeden/topserver](https://github.com/tjeden/topserver) ##

### [http://rubylearning.com/blog/2010/10/01/an-introduction-to-eventmachine-and-how-to-avoid-callback-spaghetti/](http://rubylearning.com/blog/2010/10/01/an-introduction-to-eventmachine-and-how-to-avoid-callback-spaghetti/) ###

### [http://timetobleed.com/eventmachine-scalable-non-blocking-io-in-ruby/](http://timetobleed.com/eventmachine-scalable-non-blocking-io-in-ruby/) ###
