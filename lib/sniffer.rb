require 'packetfu'
require 'json'

module Tubes
  class Sniffer
    
    #this will keep running until 
    def sniff()
      while 1 
        #get destination IP addresses from the network
        iface = TUBES_CONFIG['sniffer']['network_interface']
        address_list = capture(iface)
    
        tf = Tubes::TraceFactory::instance
        address_list.each do |ip|
          ##puts "Adding ip_address: #{ip}" #just for debugging purposes
          tf.add_to_queue(ip)
          if tf.queue_count > 100
            break 
          end
        end
      end
    end
    
    def capture(iface)
      
      ## THIS IS TEST CODE, REMOVE FOR REAL RESULTS.... CAPTURE TAKES TOOO LONG!!
      if TUBES_CONFIG['testing']['debug_values']
        return ["199.47.218.150", "141.101.124.232", "74.125.141.189", "173.196.192.212", "74.125.141.125", "205.188.0.167", "64.12.165.103", "64.12.28.153", "64.12.202.51", "204.154.94.81"]
      end
      
      address_list = Array.new
      cap = PacketFu::Capture.new(:iface => iface, :start => true, :promisc => TUBES_CONFIG['sniffer']['promiscuous'])
      cap.stream.each do |p|
        pkt = PacketFu::Packet.parse p
        if pkt.is_ip? 
          if pkt.ip_saddr == PacketFu::Utils.ifconfig(iface)[:ip_saddr]
            next
          end
          
          network_filter = TUBES_CONFIG['sniffer']['network_filter'] #apply filter for local network traffic
          if !address_list.include?(pkt.ip_saddr) && !network_filter.any? { |i| pkt.ip_saddr =~ /#{i}/ }
            address_list.push(pkt.ip_saddr)
          end
          #puts address_list.length  #show progress
          return address_list if address_list.length == 10
        end
      end
    end
  end
end