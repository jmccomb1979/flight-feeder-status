#!/bin/bash

neofetch --stdout --disable title underline uptime | awk '{print $0, "<br />"}' > /root/stats1.txt

SERVICES=( readsb tar1090 graphs1090 piaware fr24feed pfclient adsbexchange-feed ) 
rm /root/stats2.txt
for i in "${SERVICES[@]}"
  do
    STATE=`systemctl status $i | grep "Active:"`
    RUNNING=`echo $STATE | grep "active (running)"`
    SINCE=`echo $RUNNING | cut -d' ' -f 5,6,7`
    if [[ $RUNNING == "" ]]
    then
      echo "<p class=\"boldred\">$i is NOT Running!</p>">> /root/stats2.txt
    else
      echo "<p><span class=\"boldgreen\">$i</span> has been running since $SINCE GMT</p>">> /root/stats2.txt
    fi
  echo "<hr />">> /root/stats2.txt
done

cat /root/head.txt > /var/www/html/index.html
cat /root/stats1.txt >> /var/www/html/index.html
cat /root/mid.txt >> /var/www/html/index.html
cat /root/stats2.txt >> /var/www/html/index.html
cat /root/tail.txt >> /var/www/html/index.html

