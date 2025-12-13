#!/bin/bash

#layoutcontroll
if [ -f /tmp/external_m.txt ]; then

  tw=$(bspc query -d 'DP-1-1:focused' -D --names)
  locfi="/tmp/external_m.txt"

else

  tw=$(bspc query -D -d focused --names)
  locfi="/tmp/internal_m.txt"

fi

if [ "$(sed -n "${tw}p" <"$locfi")" = "tile" ]; then

  setl="tiled"
  comid=$(xprop -notype -id $1 WM_COMMAND)

  for exp in $(cat /$HOME/.config/bspwm/bspwm_exceptions.txt); do

    if [ -n "$(xprop -notype -id $1 WM_COMMAND | grep "$exp")" ]; then
      setl="floating"
    fi

  done

  if [ "$setl" = "tiled" ]; then

    echo 'state=tiled'

  else

    echo 'state=floating'

  fi

fi
