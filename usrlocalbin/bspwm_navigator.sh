#!/bin/bash

desktop() {

  if [ -f /tmp/external_m.txt ]; then
    cw=$(bspc query -d 'DP-1-1:focused' -D --names)
  else
    cw=$(bspc query -D -d focused --names)
  fi

  seld=$(

    for wid in $(bspc query -N -n .!hidden.window -d $cw); do

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

  bspc node $seld -g hidden=off -f
  bspc node $seld -g sticky=off -f

}

hidden() {

  selh=$(

    for wid in $(bspc query -N -n .hidden.window); do

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

  bspc node $selh -g hidden=off -f
  bspc node $selh -g sticky=off -f

}

all() {

  sela=$(

    for wid in $(bspc query -N -n .!hidden.window); do

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

  bspc node $sela -g hidden=off -f
  bspc node $sela -g sticky=off -f

  if [ -f /tmp/external_m.txt ]; then
    nw=$(bspc query -d 'DP-1-1:focused' -D --names)
  else
    nw=$(bspc query -D -d focused --names)
  fi

  selw=$(sed -n "${nw}p" </tmp/randwall.txt)
  hsetroot -cover $selw

}

case $1 in
-d)
  desktop
  ;;
-h)
  hidden
  ;;
-a)
  all
  ;;
*)
  exit 0
  ;;
esac
