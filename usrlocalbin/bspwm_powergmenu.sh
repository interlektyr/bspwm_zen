#!/bin/bash

echo " enter select  esc exit" >/tmp/optionsP.txt
echo "Lock" >>/tmp/optionsP.txt
echo "Shutdown" >>/tmp/optionsP.txt
echo "Reload X11" >>/tmp/optionsP.txt
echo "Reboot" >>/tmp/optionsP.txt
echo "Reboot into firmware" >>/tmp/optionsP.txt

case $(cat /tmp/optionsP.txt | fzf --layout=reverse-list --header-lines=1 --border --padding=5%,0%,0%,0% --border-label=" Power " --color=label:italic:yellow --color=border:'#1D2021' --color=pointer:magenta --color=marker:green) in
"Lock")
  slock
  ;;
"Shutdown")
  urxvtc -g 45x5 -e sh -c "gum confirm && shutdown -h now || exit"
  ;;
"Reload X11")
  urxvtc -g 45x5 -e sh -c "gum confirm && bspc quit || exit"
  ;;
"Reboot")
  urxvtc -g 45x5 -e sh -c "gum confirm && systemctl reboot || exit"
  ;;
"Reboot into firmware")
  urxvtc -g 45x5 -e sh -c "gum confirm && systemctl reboot --firmware-setup || exit"
  ;;
*)
  exit
  ;;
esac
