#!/bin/bash

case $(echo -e "enter select  esc exit\nLock\nShutdown\nReload X11\nReboot\nReboot into firmware" | fzf --info=hidden --header-lines=1 --color=pointer:magenta --color=border:'#1D2021' --footer="Power" --color=footer:italic:yellow --header-border=line --footer-border=line) in
"Lock")
  slock
  ;;
"Shutdown")
  urxvtc -g 45x5 -e sh -c "gum confirm Shutdown? --no-show-help --prompt.foreground="#DBBC7F" --selected.background="#D699B6" && shutdown -h now || exit"
  ;;
"Reload X11")
  urxvtc -g 45x5 -e sh -c "gum confirm Reload? --no-show-help --prompt.foreground="#DBBC7F" --selected.background="#D699B6" && bspc quit || exit"
  ;;
"Reboot")
  urxvtc -g 45x5 -e sh -c "gum confirm --no-show-help --prompt.foreground="#DBBC7F" --selected.background="#D699B6" && systemctl reboot || exit"
  ;;
"Reboot into firmware")
  urxvtc -g 45x5 -e sh -c "gum confirm --no-show-help --prompt.foreground="#DBBC7F" --selected.background="#D699B6" && systemctl reboot --firmware-setup || exit"
  ;;
*)
  exit
  ;;
esac
