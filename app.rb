require "#{File.expand_path File.dirname(__FILE__)}/script/init.rb" #initialize the project
require 'sinatra'

before do 
  # Strip the last / from the path
  request.env['PATH_INFO'].gsub!(/\/$/, '')
end

get '/tubes/downloads/:since?' do
  headers('Content-Type' => "application/json")
  #Download.all({ :select => 'id, date_format(created_at, "%Y%m%d%H%i%s") as `timestamp`, json_blob', :conditions => 'created_at > date_format(CURDATE(), "%Y%m%d%H%i%s")' }).to_json
  Download.all( :select => 'id, date_format(created_at, "%Y%m%d%H%i%s") as `timestamp`, json_blob', :limit => 50).to_json  #testing purposes
end

get '/' do
  erb :map
end

get '/3' do
  erb :map3
end