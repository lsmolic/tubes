#!/usr/bin/env ruby

require 'packetfu'

include PacketFu

iface = 'en1'




def sniff(iface)
  address_list = Hash.new
	cap = PacketFu::Capture.new(:iface => iface, :start => true)
	cap.stream.each do |p|
	  
		pkt = Packet.parse p
		if pkt.is_ip? 
			next if pkt.ip_saddr == Utils.ifconfig(iface)[:ip_saddr]
			#packet_info = [pkt.ip_saddr, pkt.ip_daddr, pkt.size, pkt.proto.last]
			
			if !address_list.has_key?("pkt.ip_saddr") 
			  address_list[pkt.ip_saddr] = { :ip_address => pkt.ip_saddr }
			end
			puts address_list.length
			return address_list if address_list.length == 10
		end
	end
end

def get_location(address_list)
  list_with_geo_information = address_list.clone #to avoid pointer errors 
  geocoded_address_list.each do |key, value|
    geo = Geokit::Geocoders::MultiGeocoder.geocode(value[:ip_address])
    if geo.lat.nil?
      geocoded_address_list.delete
    else
      geocoded_address_list[key]
    end
  end
  
end

address_list = sniff(iface)



puts address_list.inspect