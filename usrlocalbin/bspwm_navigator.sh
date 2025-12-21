#!/bin/bash

init() {
  touch /tmp/hwlist.txt
  touch /tmp/hwidlist.txt
  exit
}

main() {

  n=0

  if [ "$mode" = "vd" ]; then

    if [ -f /tmp/external_m.txt ]; then
      cw=$(bspc query -d 'DP-1-1:focused' -D --names)
    else
      cw=$(bspc query -D -d focused --names)
    fi

    mq=$(bspc query -N -n .!hidden.window -d $cw)
    type="mapped windows on the current desktop"
  elif [ "$mode" = "vh" ]; then
    mq=$(bspc query -N -n .hidden.window)
    type="unmapped windows"
  elif [ "$mode" = "va" ]; then
    type="mapped windows on all desktops"
    mq=$(bspc query -N -n .!hidden.window)
  fi

  if [ ! -f /tmp/widlist.txt ]; then
    touch /tmp/widlist.txt
  fi

  echo -e "esc quit" >/tmp/widlist.txt

  for wid in $mq; do

    echo -e "$(xprop -notype -id $wid WM_NAME | cut -d'"' -f2) | $(xprop -notype -id $wid WM_CLASS | cut -d'"' -f2)\e[1;90m | $wid\e[0m" >>/tmp/widlist.txt

  done

  sel=$(

    cat /tmp/widlist.txt | fzf --ansi --bind "ctrl-s:execute(appcommander.sh u)+become(appcommander.sh)" \
      --info=hidden --header-lines=1 --border --padding=5%,0%,0%,0% \
      --border-label=" Navigator ($type) " --border-label-pos=3 --color=label:italic:yellow --color=border:'#1D2021' \
      --color=pointer:magenta --color=marker:green --header-border=line --footer-border=line | cut -d'|' -f3

  )

  #if [ $n = 0 ]; then
  #  echo "Found no windows hidden by user"
  #  sleep 1
  #  exit
  #fi

  bspc node $sel -g hidden=off -f
  bspc node $sel -g sticky=off -f

  if [ "$mode" = "va" ]; then

    if [ -f /tmp/external_m.txt ]; then
      nw=$(bspc query -d 'DP-1-1:focused' -D --names)
    else
      nw=$(bspc query -D -d focused --names)
    fi

    selw=$(sed -n "${nw}p" </tmp/randwall.txt)
    hsetroot -cover $selw
  fi

  exit 0
}

case $1 in
-d)
  mode="vd"
  main
  ;;
-h)
  mode="vh"
  main
  ;;
-a)
  mode="va"
  main
  ;;
*)
  exit 0
  ;;
esac
