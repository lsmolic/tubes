#this class tracks all the elements of a particular request

require 'ipaddress'

module Tubes
  class Request
    attr_reader :locations, :origin_ip, :destination_ip
    
    def initialize(destination_ip)
      @destination_ip = destination_ip
      @origin_ip      = TUBES_CONFIG['traceroute']['origin_ip_address']
      @locations      = Array.new
    end

    def trace_me!
      if !IPAddress.valid?(@origin_ip) || !IPAddress.valid?(@destination_ip)
         raise ArgumentError "This method requires valid origin and destination IP Addresses."
      end
      tr = Tubes::TraceRoute.new
      if tr.find!(@destination_ip, @origin_ip)
        tr.ip_list.each do |ip|
          location = Tubes::Location.new(ip)
          @locations.push(location)
        end
        return true
      end
      return false
    end
    
    def geocode_locations!
      if @locations.nil? || @locations.length == 0
        return
      end
      #puts request.inspect #debugging info before going to the geo-coding service
      gf = Tubes::GeocoderFactory.instance
      gf.add_to_queue(self)
    end
  end
end
