Tubes
=====

What I'm building:

1. Acquire traffic from wireless
2. Put remote IP address from traffic into a queue for traceroute
3. Run traceroute on queue and place IPs and create 
4. Run geocoder on each ip and store a lat/long for each IP in the stored hashes
5. Store calculated figures in a database with timestamp 
      (also store a source_ip, destination_ip and json_blob in cache table for quicker results on duplicate requests)
6. Create webservice for javascript to poll periodically and show, based on timestamp, traffic that has occurred since last polling
7. Create javascript animation on map showing the animation of trace routes emanating from the wifi IP location.


+ organization of data
- request => 
	- location => 
		- ip
		- lat,long
		- etc.
		
1. run trace on destination to get locations
2. create request from locations
3. run geocode on each request's locations

#mapping the locations
http://www.wolfpil.de/v3/arrow-heads.html -->> used as a primer for the google mapping
http://gmaps-samples-v3.googlecode.com/svn/trunk/styledmaps/wizard/index.html  -->> styling the maps
http://rectangleworld.com/demos/FireTrails/FireTrails.html  -->> firetrails
http://econym.org.uk/gmap/example_cartrip2.htm -->> animating the polylines


#Commands you will find useful
#default environment is development, set with ENV=production
rake db:migrate VERSION=#  (for rolling back)
rvmsudo script/console  (my version of the rails console, it just wraps irb and includes lib files and inits the project)
rvmsudo script/server   (this sniffs the )
ruby script/tubes.rb


#some configurations for a Mac w/ Snow Leopard
ARCHFLAGS="-arch i386" gem install mysql2 -- --with-mysql config=/usr/local/mysql/bin/mysql_config
sudo install_name_tool -change libmysqlclient.16.dylib /usr/local/mysql-5.5.8-osx10.6-x86_64/lib/libmysqlclient.16.dylib /Users/lsmolic/.rvm/gems/ruby-1.9.3-p125\@sniff/gems/mysql2-0.3.11/lib/mysql2/mysql2.bundle
install_name_tool -change libmysqlclient.16.dylib /usr/local/mysql-5.5.8-osx10.6-x86_64/lib/libmysqlclient.16.dylib /Users/lsmolic/.rvm/gems/ruby-1.9.3-p125\@sniff/gems/mysql2-0.3.11/lib/mysql2/mysql2.bundle

#some web resources that have help build this
http://www.ruby-forum.com/topic/198260 - unsigned bigint on migration
https://github.com/rails/rails/issues/4670 - remember to manually close DB connections. Model.connections.close, ActiveRecord doesn't for some reason

