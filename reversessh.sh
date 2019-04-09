#!/bin/bash
createTunnel() {
  /usr/bin/ssh -N -R 2222:localhost:22 serverUser@25.25.25.25 # actual server name goes here
  if [[ $? -eq 0 ]]; then
    echo Tunnel to Raspberry Pi created successfully
  else
    echo An error occurred creating a tunnel to Raspberry Pi. RC was $?
  fi
}
/bin/pidof ssh
if [[ $? -ne 0 ]]; then
  echo Creating new tunnel connection
  createTunnel
fi
