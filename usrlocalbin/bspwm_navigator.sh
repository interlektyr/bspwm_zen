#!/bin/bash

init() {
  touch /tmp/wlist.txt
  touch /tmp/widlist.txt
  exit
}

main() {
  truncate -s 0 /tmp/wlist.txt
  truncate -s 0 /tmp/widlist.txt
  n=0

  for wid in $(bspc query -N -n .!hidden.window); do
    n=$((n + 1))
    echo $wid >>/tmp/widlist.txt
    echo "$n: $(xprop -notype -id $wid WM_NAME | cut -d'"' -f2) | $(xprop -notype -id $wid WM_CLASS | cut -d'"' -f2)" >>/tmp/wlist.txt
  done

  if [ $n = 0 ]; then
    echo "Found no mapped windows at all"
    sleep 1
    exit
  fi

  v=$(gum filter --header "Navigator (all desktops)" </tmp/wlist.txt | cut -d: -f1)

  sel=$(sed -n "${v}p" </tmp/widlist.txt)

  bspc node $sel -g hidden=off -f
  bspc node $sel -g sticky=off -f

  xrandr -q | grep "DP-1-1 connected" && cw=$(bspc query -d 'DP-1-1:focused' -D --names)
  xrandr -q | grep "DP-1-1 connected" || cw=$(bspc query -D -d focused --names)
  sel=$(sed -n "${cw}p" </tmp/randwall.txt)
  hsetroot -cover $sel

  exit 0
}

otd() {
  truncate -s 0 /tmp/wlist.txt
  truncate -s 0 /tmp/widlist.txt
  n=0

  xrandr -q | grep "DP-1-1 connected" && tw=$(bspc query -d 'DP-1-1:focused' -D --names)
  xrandr -q | grep "DP-1-1 connected" || tw=$(bspc query -D -d focused --names)

  for wid in $(bspc query -N -n .!hidden.window -d $tw); do
    n=$((n + 1))
    echo $wid >>/tmp/widlist.txt
    echo "$n: $(xprop -notype -id $wid WM_NAME | cut -d'"' -f2) | $(xprop -notype -id $wid WM_CLASS | cut -d'"' -f2)" >>/tmp/wlist.txt
  done

  if [ $n = 0 ]; then
    echo "Found no mapped windows on this desktop"
    sleep 1
    exit
  fi

  v=$(gum filter --header "Navigator (current desktop)" </tmp/wlist.txt | cut -d: -f1)

  sel=$(sed -n "${v}p" </tmp/widlist.txt)

  bspc node $sel -g hidden=off -f
  bspc node $sel -g sticky=off -f

  exit 0
}

case $1 in
init)
  init
  ;;
otd)
  otd
  ;;
*)
  main
  ;;
esac
