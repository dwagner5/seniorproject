#!/bin/bash
# Dakota Wagner 3/14/19

# Set up
cd /home/pi/scripts/remote_desktop_machines/
current_time=$(date "+%Y.%m.%d-%H.%M.%S")


# Get IP
ip=$(hostname  -I | cut -f1 -d' ')
# Set ip to a range, for example, 192.168.4.8 becomes 192.168.4.0-254
ip="${ip::-1}""0-254"
echo $ip
# Get all computers in the specified network range that have the remote desktop port open
echo "Scanning for remote desktop machines"
nmap --open -p 3389 $ip -oG - | grep "/open" | awk '{ print $2 }' > "remote_desktop_log_$current_time.txt"
echo "Done."

#Get the file
newestfilename="`ls -t $dir| head -1`"

echo "writing to ftp"

ftp -n <<EOF
open ftp server 
user username password
cd /remote_desktop_machines/
put $newestfilename
EOF


echo "cleaning up"
rm $newestfilename

echo "done!"
