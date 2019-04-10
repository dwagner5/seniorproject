#!/bin/bash
echo "Getting MACs"
/home/pi/scripts/MAC_Addresses/get_mac.sh
echo "Finding remote desktop machines"
/home/pi/scripts/remote_desktop_machines/get_remote_desktop_computer.sh
