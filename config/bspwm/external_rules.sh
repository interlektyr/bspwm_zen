#!/bin/bash

if [ -f /tmp/external_m.txt ]; then

  tw=$(bspc query -d 'DP-1-1:focused' -D --names)

  if [ "$(sed -n "${tw}p" </tmp/external_m.txt)" = "tile" ]; then
    echo 'state=tiled'
  fi

else

  tw=$(bspc query -D -d focused --names)

  if [ "$(sed -n "${tw}p" </tmp/internal_m.txt)" = "tile" ]; then
    echo 'state=tiled'
  fi

fi
