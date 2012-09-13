#this class will hold the information for a specific ip_address and it's geocode information

require 'ipaddress'
require 'geokit'

module Sniff
  class Location
    attr_reader :ip_address, :latitude, :longitude, :street, :city, :state, :zip, :country
  
    @ip_address = ''
    @latitude = ''
    @longitude = ''
    @street = ''
    @city = ''
    @state = ''
    @zip = ''
    @country = ''
  
    def initialize(ip_address)
      if !IPAddress.valid? ip_address
        raise ArgumentError "This class requires a valid IP Address."
      end
      @ip_address = ip_address
    end
  
    def geocode_me!
      if !@ip_address.empty?
        geo = Geokit::Geocoders::MultiGeocoder.geocode(@ip_address)
        if geo.success?
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