#!/bin/bash

# Set up
cd /home/pi/scripts/
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

# Get IP
ip=$(hostname  -I | cut -f1 -d' ')
# Set ip to a range, for example, 192.168.4.8 becomes 192.168.4.*
ip="${ip::-2}""*"

# Scan for devices
nmap -sP $ip > "devices_$current_time.txt"

#Get the file
newestfilename="`ls -t $dir| head -1`"

echo "writing to ftp"

ftp -n <<EOF
open ftp.drivehq.com 
user dwagner5 applejacks420
cd /devices/
put $newestfilename
EOF

echo "cleaning up"
rm $newestfilename

echo "done!"
