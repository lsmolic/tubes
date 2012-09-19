#this class handles the actual traceroute functionality and stores the results in a public property 
#it Currently only works with IP addresses

require 'timeout'
require 'socket'
require 'ipaddress'


module Tubes
  class TraceRoute
    attr_reader :ip_list
    
    TRACEROUTE=`which traceroute`.chomp   #you could also install and use tcptraceroute
  
    def initialize()
      @timeout = TUBES_CONFIG['traceroute']['timeout']
      @ip_list = []
    end

    def find!(destination_ip, origin_ip)
      @destination_ip = destination_ip
      if !IPAddress.valid?(@destination_ip)
        raise ArgumentError "This class requires a valid IP Address."
      end 
      begin
        if TUBES_CONFIG['testing']['debug_values']
          @ip_list = [origin_ip, rand_ip, rand_ip, rand_ip, rand_ip, rand_ip, rand_ip, rand_ip, @destination_ip]
          return true
        end
          #adding a timeout in bash so we still receive some output from the command
          trace = `#{TRACEROUTE} -n #{@destination_ip} & sleep #{@timeout}; if ps aux | awk '{print $2 }' | grep $! > /dev/null; then kill -9 $!; fi`
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
    
    def rand_ip
      Array.new(4){rand(256)}.join('.')
    end
  end
end




