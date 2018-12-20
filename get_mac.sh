#!/bin/bash

echo "creating file."
cd /home/pi/scripts/MAC_Addresses/

current_time=$(date "+%Y.%m.%d-%H.%M.%S")

arp -a | awk 'BEGIN{print "MAC Addresses on the network:"}{print $4}END{print "Done!"}' > "mac_address_log_$current_time.txt"

newestfilename="`ls -t $dir| head -1`"

echo "writing to ftp"

ftp -n <<EOF
open ftpserver
user username password
cd /mac_addresses/
put $newestfilename
EOF


echo "cleaning up"
rm $newestfilename

echo "done!"
