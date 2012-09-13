sniff
=====

What I'm building:

1. Acquire traffic from wireless
2. Put remote IP address from traffic into Array of Hashes
3. Run trace route on Array and place IPs in each destination IP address's hash
4. Run geocoder on each ip and store a lat/long for each IP in the stored hashes
5. Store calculated figures in a database with timestamp
6. Create webservice for javascript to poll periodically and show, based on timestamp, traffic that has occurred since last polling
7. Create javascript animation on map showing the animation of trace routes emanating from the wifi IP location.

