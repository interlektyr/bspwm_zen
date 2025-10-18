#!/usr/bin/env bash

 
__batbar() {
  echo -e -n "%{c}BAT$(acpi --battery | cut -d, -f2)"
  sleep 30s
  }
  
while true; do
 BATPERC=$(acpi --battery | cut -d, -f2 | cut -d% -f1)
 if [ $BATPERC -lt 10 ]; then
  __batbar | lemonbar -b -d -g 90x40+110+10 -F#1d2021 -B#ebcb8b -o 0 -f "DepartureMonoNerdFont-10" >/dev/null 2>&1;
 fi
 sleep 120s
done


