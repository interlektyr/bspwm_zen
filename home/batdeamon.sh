#!/usr/bin/env bash

__batbarD() {
  echo -e -n "%{c}BAT$(acpi --battery | cut -d, -f2 | tr -d ' ')"
  sleep 30s
}

while true; do
  BATPERC=$(acpi --battery | cut -d, -f2 | cut -d% -f1)
  geom="80x40+2470+10"
  barbcolor="#E67E80"
  if [ $BATPERC -lt 15 ]; then
    __batbarD | lemonbar -b -d -g ${geom} -F#1d2021 -B${barbcolor} -o 0 -f "DepartureMonoNerdFont-10" >/dev/null 2>&1
  fi
  sleep 120s
done
