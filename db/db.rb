# this is a SINGLETON class for looking up and processing data from the geo coder

require 'active_record'
require 'mysql2'

db_config = YAML::load(File.open("#{ROOT_DIR}/config/database.yml"))[ENV['ENV'] ? ENV['ENV'] : 'development']
ActiveRecord::Base.establish_connection(db_config)
