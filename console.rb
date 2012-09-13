#!/usr/bin/env ruby

Dir[File.dirname(__FILE__) + "/lib/**/*.rb"].each do |file|
  require file
end

require 'irb'
ARGV[0] = '-I'
ARGV[1] = '/Users/lsmolic/Repos/sniff/'
IRB.start
