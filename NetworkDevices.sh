#!/bin/bash

# Set up
cd /home/pi/scripts/
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

# Get IP
ip=$(hostname  -I | cut -f1 -d' ')
# Set ip to a range, for example, 192.168.4.8 becomes 192.168.4.8-255
ip="${ip::-1}""-255"

# Scan for devices
nmap $ip | tee "devices_$current_time.txt"

#Get the file
newestfilename="`ls -t $dir| head -1`"

echo "writing to ftp"

ftp -n <<EOF
open ftp server 
user username password
cd /devices/
put $newestfilename
EOF

echo "cleaning up"
rm $newestfilename

echo "done!"
