# this is a SINGLETON class for looking up and processing data from the geo coder
require 'eventmachine'

module Tubes
  class GeocoderFactory
    
    def initialize
      @@geocoder_queue = Queue.new
      @@thread_count = 0
    end
    
    @@running = false
    @@instance = GeocoderFactory.new
    
    def self.instance
      return @@instance
    end
    
    def start
      if !@@running
        @@running = true
        process
      end
    end
    
    def add_to_queue(request)
      @@geocoder_queue.push(request)
      start
    end
    private_class_method :new
    
    private
    def process
      while @@geocoder_queue.length > 0
        time = Time.new
        if time.usec.to_i == 0
          #puts "GeocoderFactory running... Queue length:#{@@geocoder_queue.length}"
        end
        if @@thread_count < TUBES_CONFIG['geocoder']['thread_limit'] || 5
          thread = Thread.new {
            begin
              @@thread_count += 1
              request = @@geocoder_queue.pop
              locations = request.locations.clone
              locations.each do |location|
                if location.geocode_me!
                  location.inspect
                  #puts "LOCATION: #{location.latitude}, #{location.longitude}"
                else
                  request.locations.delete(location)
                end
              end 
              Download.create(
                :json_blob => request.to_json
              )
              #puts "locations.length: #{request.locations.length}"
            rescue
              @@thread_count -= 1
              puts "Something went while geocoding a location"
            end
          }
        end
      end
      @@running = false
    end
  end
end