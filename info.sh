#!/bin/bash

neofetch --stdout --disable title underline uptime | awk '{print $0, "<br />"}' > /root/stats1.txt

echo "Uptime @ "`uptime`| awk '{print $0, "<br />"}' > /root/stats2.txt
echo "<hr/>">> /root/stats2.txt
echo "<b>readsb status:</b>" `systemctl status readsb | grep Active| awk '{print $0, "<br />"}'`>> /root/stats2.txt
echo "<hr/>">> /root/stats2.txt
echo "<b>tar1090 status:</b>" `systemctl status tar1090 | grep Active| awk '{print $0, "<br />"}'`>> /root/stats2.t>
echo "<hr/>">> /root/stats2.txt
echo "<b>graphs1090 status:</b>" `systemctl status graphs1090 | grep Active| awk '{print $0, "<br />"}'`>> /root/st>
echo "<hr/>">> /root/stats2.txt
echo "<b>Flightaware status:</b>" `systemctl status piaware | grep Active| awk '{print $0, "<br />"}'`>> /root/stat>
echo "<hr/>">> /root/stats2.txt
echo "<b>Flight Radar 24 status:</b>" `systemctl status fr24feed | grep Active| awk '{print $0, "<br />"}'`>> /root>
echo "<hr/>">> /root/stats2.txt
echo "<b>Planefinder status:</b>" `systemctl status pfclient | grep Active| awk '{print $0, "<br />"}'`>> /root/sta>
echo "<hr/>">> /root/stats2.txt
echo "<b>ADSBexchange status:</b>" `systemctl status adsbexchange-feed | grep Active| awk '{print $0, "<br />"}'`>>>
echo "<hr/>">> /root/stats2.txt

cat /root/head.txt > /var/www/html/index.html
cat /root/stats1.txt >> /var/www/html/index.html
cat /root/mid.txt >> /var/www/html/index.html
cat /root/stats2.txt >> /var/www/html/index.html
cat /root/tail.txt >> /var/www/html/index.html

