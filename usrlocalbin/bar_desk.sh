#!/usr/bin/env bash

lemondesk() {
  echo -e -n "%{c}DESKTOP:$(bspc query -D -d focused --names)"

  case $1 in
  s)
    sleep 1
    ;;
  l)
    sleep 2
    ;;
  esac

  sleep 1
}

lemondesk | lemonbar -b -d -g 180x50+10+10 -F#1d2021 -B#ebbcba -o 0 -f "DepartureMonoNerdFont-12" >/dev/null 2>&1
#118
