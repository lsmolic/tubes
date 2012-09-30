require "#{File.expand_path File.dirname(__FILE__)}/script/init.rb" #initialize the project
require 'sinatra'

before do 
  # Strip the last / from the path
  request.env['PATH_INFO'].gsub!(/\/$/, '')
end

get '/tubes/downloads/latest' do
  headers('Content-Type' => "application/json")
  downloads = Download.all( :select => 'id, date_format(created_at, "%Y%m%d%H%i%s") as `timestamp`, json_blob', :limit => 50, :order => "created_at DESC") 
  Download.connection.close
  downloads.to_json
end

get '/' do
  erb :map
end

get '/3' do
  erb :map3
end