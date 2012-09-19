#this is a SINGLETON class for queueing reqeuests for traceroute to be run and then ferries them on to the GeoFactory
require 'eventmachine'

module Tubes
  class TraceFactory
    def initialize
      @@trace_queue = Queue.new
      @@thread_count = 0
    end
    
    @@running = false
    @@instance = TraceFactory.new
    
    def self.instance
      return @@instance
    end
    
    def start
      if !@@running 
        @@running = true
        process
      end
    end
    
    def add_to_queue(destination_ip)
      @@trace_queue.push(destination_ip)
      start
      #puts "Queue length:#{@@trace_queue.length}"
    end
    
    def queue_count
      @@trace_queue.length
    end
    
    private
    def process
      while @@trace_queue.length > 0
        time = Time.new
        if time.usec.to_i == 0
          #puts "TraceFactory running... Queue length:#{@@trace_queue.length}"   #this is just for debugging
        end
        if @@thread_count < TUBES_CONFIG['traceroute']['thread_limit'] || 5
          thread = Thread.new {
            begin
               @@thread_count += 1
              destination_ip = @@trace_queue.pop
              request = Tubes::Request.new(destination_ip)
              request.trace_me!
              request.geocode_locations!
              Thread.current[:output] = request
            rescue
              @@thread_count -= 1
              puts "Something went while tracing an IP"
            ensure
              Thread.exit
            end
          }
          thread.join
          req = thread[:output]
          Thread.kill(thread)
        end
      end
      @@running = false
    end
  end
end