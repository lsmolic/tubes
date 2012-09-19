require 'yaml'

ROOT_DIR = "/Users/lsmolic/Repos/tubes"

#load constants from config.yml
TUBES_CONFIG = YAML::load_file("#{ROOT_DIR}/config/config.yml")[ENV['ENV'] ? ENV['ENV'] : 'development']

require "#{ROOT_DIR}/db/db.rb"

#require all lib files
Dir["#{ROOT_DIR}/lib/**/*.rb"].each do |file|  
  require file
end