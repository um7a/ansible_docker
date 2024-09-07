#!/bin/bash

signal_received=0

function handle_signal() {
  signal_received=1
}

trap handle_signal SIGTERM 

while true
do
  sleep 1
  if [[ $signal_received == 1 ]]
  then
    exit 0
  fi
done
