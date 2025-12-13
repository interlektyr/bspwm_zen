#!/bin/bash

#layoutcontroll
if [ -f /tmp/external_m.txt ]; then

  tw=$(bspc query -d 'DP-1-1:focused' -D --names)

  if [ "$(sed -n "${tw}p" </tmp/external_m.txt)" = "tile" ]; then

    setl="tiled"
    comid=$(xprop -notype -id $1 WM_COMMAND)

    for exp in $(cat /$HOME/.config/bspwm/bspwm_exceptions.txt); do

      #if [ "$comid" == *"$exp"* ]; then
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

  #if [ -z "$(xprop -notype -id $1 WM_COMMAND | grep "appcommander.sh")" ]; then

  #  echo 'state=tiled'

  #fi

else

  tw=$(bspc query -D -d focused --names)

  if [ "$(sed -n "${tw}p" </tmp/internal_m.txt)" = "tile" ]; then
    echo 'state=tiled'
  fi

fi
