#this class handles the actual traceroute functionality and stores the results in a public property 
#it Currently only works with IP addresses

require 'timeout'
require 'set'
require 'socket'
require 'pp'
require 'ipaddress'

module Sniff
  class TraceRoute
    attr_reader :ip_list
    
    TRACEROUTE=`which traceroute`.chomp
  
    def initialize(timeout=5)
      @timeout = timeout unless timeout.nil?
      @ip_list = []
    end

    def find!(destination_ip)
      @destination_ip = destination_ip
      if !IPAddress.valid?(@destination_ip)
        raise ArgumentError "This class requires a valid IP Address."
      end 
      begin
          #adding a timeout in bash so we still receive some output from the command
          trace = `#{TRACEROUTE} -n #{@destination_ip} & sleep #{@timeout} ; kill -9 $!`
          process_trace(trace)
          return true
      rescue; end
      false
    end
  
    private
    def process_trace(trace)
      #puts trace
      trace.split("\n").each do |line|
        if !line.nil? && !line.split[1].nil? && IPAddress.valid?(line.split[1]) && !@ip_list.include?(line.split[1])
          #puts "#{line.split[1]}"
          @ip_list.push(line.split[1]) 
        end
      end
    end
  end
end




