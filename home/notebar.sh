#!/usr/bin/env bash

__note() {
  echo -e -n "%{c}D$(bspc query -D -d focused --names)"

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

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Main application
[ -n "$(type -P lemonbar)" ] || { echo "lemonbar is not installed" && exit 1; }
__note | lemonbar -b -d -g 50x40+110+10 -F#FFFFFFFF -B#1d2021 -o 0 -f "DepartureMonoNerdFont-10" >/dev/null 2>&1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ex: ts=2 sw=2 et filetype=sh
# -p
