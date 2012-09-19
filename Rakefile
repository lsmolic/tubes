require 'active_record'
require 'yaml'

require "#{File.expand_path File.dirname(__FILE__)}/script/init.rb" #initialize the project

namespace :db do
  desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end

  task :environment do
    db_config = YAML::load(File.open("#{ROOT_DIR}/config/database.yml"))[ENV['ENV'] ? ENV['ENV'] : 'development']
    ActiveRecord::Base.establish_connection(db_config)
    #ActiveRecord::Base.logger = Logger.new(File.open("database.log", "a"))
  end
end