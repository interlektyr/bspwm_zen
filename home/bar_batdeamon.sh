#!/usr/bin/env bash

while true; do

  BATPERCD=$(acpi --battery | cut -d, -f2 | cut -d% -f1)
  CHADD=$(acpi -a | cut -d: -f2)
  
  if [ $BATPERCD -lt 15 ] && [ $CHADD != "on-line" ]; then
    
    ./bar_bat.sh   

  fi
  
  sleep 300s
done
