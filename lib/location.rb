#this class will hold the information for a specific ip_address and it's geocode information

require 'ipaddress'
require 'geokit'

module Tubes
  class Location
    attr_reader :ip_address, :latitude, :longitude, :street, :city, :state, :zip, :country
    
    def initialize(ip_address)
      if !IPAddress.valid? ip_address
        raise ArgumentError "This class requires a valid IP Address."
      end
      @ip_address = ip_address
      @latitude, @longitude, @street, @city, @state, @zip, @country = ''
    end
    
    def geocode_me!
      if !@ip_address.empty?
        geo = Geokit::Geocoders::MultiGeocoder.geocode(@ip_address)
        #puts "success: #{geo.success}"
        if geo.success
          puts "#{geo.lat}, #{geo.lng}, #{geo.street_address}, #{geo.city}, #{geo.state}, #{geo.zip}, #{geo.country}"
          @latitude   = geo.lat
          @longitude  = geo.lng
          @street     = geo.street_address
          @city       = geo.city
          @state      = geo.state
          @zip        = geo.zip
          @country    = geo.country
          return true
        else
          return false
        end
      end
    end
  end
end