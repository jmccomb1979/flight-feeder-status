# flight-feeder-status
Simple status page for my readsb-based ADSB feeder

You will need neofetch installed on your Pi
'apt-get install neofetch'

Copy the info.sh and .txt files to /root/
Copy the default.css to /var/www/html/
Make a symlink from /var/www/html/stats-graphs to /run/graphs1090 

Add the script as a cron job for root every 15 minutes.
