#!/bin/bash

# Clear the stats files before we begin
/usr/bin/truncate -s 0 /root/stats1.txt
/usr/bin/truncate -s 0 /root/stats2.txt

#  Generate the left side infopanel with system details
echo "Updated at: `date` <br />" > /root/stats1.txt
echo "Uptime: `/usr/bin/uptime -p | /usr/bin/cut -d ' ' -f 2,3,4,5,6,7` <br />">> /root/stats1.txt
echo "Load Average: `/usr/bin/uptime | /usr/bin/cut -d ' ' -f 13,14,15` <br />">> /root/stats1.txt
/usr/bin/fastfetch --structure "OS:Host:CPU:Memory:GPU:Kernel:Packages:Shell:Terminal" -l none --pipe | /usr/bin/awk '{print $0, "<br />"}' >> /root/stats1.txt

# Generate the right side infopanel with status of the necessary services
SERVICES=('readsb' 'tar1090' 'graphs1090' 'piaware' 'fr24feed' 'pfclient' 'adsbexchange-feed')
echo "" > /root/stats2.txt
for i in "${SERVICES[@]}"
  do
   #echo checking $i 
    STATE=`/usr/bin/systemctl status $i | /usr/bin/grep "Active:"`
    RUNNING=`echo $STATE | /usr/bin/grep "active (running)"`
    SINCE=`echo $RUNNING | /usr/bin/cut -d' ' -f 5,6,7`
    if [[ $RUNNING == "" ]]
    then
      echo "<p class=\"boldred\">$i is NOT Running!</p>">> /root/stats2.txt
    else
      echo "<p><span class=\"boldgreen\">$i:</span> up since $SINCE GMT</p>">> /root/stats2.txt
    fi
  echo "<hr />">> /root/stats2.txt
done

# Concatenate the stats files and the base html files to build the status page
/usr/bin/cat /root/head.txt > /var/www/html/index.html
/usr/bin/cat /root/stats1.txt >> /var/www/html/index.html
/usr/bin/cat /root/mid.txt >> /var/www/html/index.html
/usr/bin/cat /root/stats2.txt >> /var/www/html/index.html
/usr/bin/cat /root/tail.txt >> /var/www/html/index.html


