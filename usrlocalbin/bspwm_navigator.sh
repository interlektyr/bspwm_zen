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

    sel=$(

      for wid in $mq; do

        n=$((n + 1))

        if [ $n = 1 ]; then
          echo "esc quit $mode"
        else
          echo -e "$(xprop -notype -id $wid WM_NAME | cut -d'"' -f2) | $(xprop -notype -id $wid WM_CLASS | cut -d'"' -f2)\e[1;90m | $wid\e[0m"
        fi

      done | fzf --ansi --bind "ctrl-s:execute(appcommander.sh u)+become(appcommander.sh)" \
        --info=hidden --header-lines=1 --border --padding=5%,0%,0%,0% \
        --border-label=" Navigator ($type) " --border-label-pos=3 --color=label:italic:yellow --color=border:'#1D2021' \
        --color=pointer:magenta --color=marker:green --header-border=line --footer-border=line | cut -d'|' -f3
    )

  elif [ "$mode" = "vh" ]; then
    mq=$(bspc query -N -n .hidden.window)
    type="unmapped windows"

    sel=$(

      for wid in $mq; do

        n=$((n + 1))

        if [ $n = 1 ]; then
          echo "esc quit $mode"
        else
          echo -e "$(xprop -notype -id $wid WM_NAME | cut -d'"' -f2) | $(xprop -notype -id $wid WM_CLASS | cut -d'"' -f2)\e[1;90m | $wid\e[0m"
        fi

      done | fzf --ansi --bind "ctrl-s:execute(appcommander.sh u)+become(appcommander.sh)" \
        --info=hidden --header-lines=1 --border --padding=5%,0%,0%,0% \
        --border-label=" Navigator ($type) " --border-label-pos=3 --color=label:italic:yellow --color=border:'#1D2021' \
        --color=pointer:magenta --color=marker:green --header-border=line --footer-border=line | cut -d'|' -f3
    )

  elif [ "$mode" = "va" ]; then
    type="mapped windows on all desktops"
    mq=$(bspc query -N -n .!hidden.window)

    sel=$(

      for wid in $mq; do

        n=$((n + 1))

        if [ $n = 1 ]; then
          echo "esc quit $mode"
        else
          echo -e "$(xprop -notype -id $wid WM_NAME | cut -d'"' -f2) | $(xprop -notype -id $wid WM_CLASS | cut -d'"' -f2)\e[1;90m | $wid\e[0m"
        fi

      done | fzf --ansi --bind "ctrl-s:execute(appcommander.sh u)+become(appcommander.sh)" \
        --info=hidden --header-lines=1 --border --padding=5%,0%,0%,0% \
        --border-label=" Navigator ($type) " --border-label-pos=3 --color=label:italic:yellow --color=border:'#1D2021' \
        --color=pointer:magenta --color=marker:green --header-border=line --footer-border=line | cut -d'|' -f3
    )

  fi

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
