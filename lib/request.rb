#this class tracks all the elements of a particular request

require 'ipaddress'

module Sniff
  class Request
    
    def initialize(destination_ip, origin_ip='173.196.192.210')
      @destination_ip = destination_ip
      @origin_ip      = origin_ip
      @locations      = Array.new
    end
  
    def trace_me!
      if !IPAddress.valid?(@origin_ip) || !IPAddress.valid?(@destination_ip)
         raise ArgumentError "This method requires valid origin and destination IP Addresses."
      end
      tr = Sniff::TraceRoute.new
      if tr.find!(@destination_ip)
        @locations = tr.ip_list
        return true
      end
      return false
    end
  end
end