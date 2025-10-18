#!/usr/bin/env bash

__lemonbar() {
  Clock() {
    TIME=$(date "+%H:%M")
    echo -e -n "${TIME}"
  }

  while true; do
    echo -e "%{c}$(Clock)" 
    sleep 1.0s
  done
}

__note() {
  echo -e -n " Test"
  sleep 1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Main application
[ -n "$(type -P lemonbar)" ] || { echo "lemonbar is not installed" && exit 1; }
__lemonbar | lemonbar -n clockbar -p -b -d -g 90x40+10+10 -F#ebbcba -B#1d2021 -o 0 -f "DepartureMonoNerdFont-14" >/dev/null 2>&1 &xfon
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ex: ts=2 sw=2 et filetype=sh
# -p
