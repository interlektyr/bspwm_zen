#!/bin/bash

if [ -f /tmp/external_m.txt ]; then
  tw=$(bspc query -d 'DP-1-1:focused' -D --names)
  tnot="/tmp/external_m.txt"
else
  tw=$(bspc query -D -d focused --names)
  tnot="/tmp/internal_m.txt"
fi

for wid in $(bspc query -N -n .!hidden.window -d $tw); do

  if [ -z "$(bspc query -N -n $wid.tiled)" ]; then
    bspc node -i
    bspc node -f $wid
    bspc node $wid -t tiled
    bspc node $wid -n $(bspc query -N -n .leaf.\!window -d focused)
  else
    bspc node $wid -t floating
  fi

done

if [ "$(sed -n "${tw}p" <$tnot)" = "float" ]; then
  sed -i "${tw}s/float/tile/" $tnot
else
  sed -i "${tw}s/tile/float/" $tnot
fi
