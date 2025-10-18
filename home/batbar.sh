#!/usr/bin/env bash

geom="80x40+2470+10"

BATPERC=$(acpi --battery | cut -d, -f2 | cut -d% -f1)
chad=$(acpi -a | cut -d: -f2)

if [ $chad = "on-line" ]; then

  __batbar() {
    echo -e -n "%{c}AC$(acpi --battery | cut -d, -f2 | tr -d ' ')"
    sleep 3s
  }

  if [ $BATPERC -lt 15 ] || [ $BATPERC -gt 70 ]; then
    barbcolor="#DBBC7F"

  else
    barbcolor="#A7C080"

  fi

  if [ $BATPERC -gt 85 ]; then
    barbcolor="#E67E80"
  fi

else

  __batbar() {
    echo -e -n "%{c}BAT$(acpi --battery | cut -d, -f2 | tr -d ' ')"
    sleep 3s
  }

  if [ $BATPERC -lt 15 ]; then
    barbcolor="#E67E80"
    dunstify -u critical -i /$HOME/.config/bspwm/bspwm_logo.svg -h string:x-dunst-stack-tag:wc "Low Battery!"

  elif [ $BATPERC -lt 25 ] || [ $BATPERC -gt 70 ]; then
    barbcolor="#DBBC7F"

  else
    barbcolor="#DBBC7F"

  fi

fi

__batbar | lemonbar -b -d -g ${geom} -F#1d2021 -B${barbcolor} -o 0 -f "DepartureMonoNerdFont-10" >/dev/null 2>&1
