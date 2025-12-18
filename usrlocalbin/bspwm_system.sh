#!/bin/sh

case $(echo -e "enter select  esc exit\nManage snapshots\nClean up system\nCachy Hello\nMonitor system" | fzf --info=hidden --header-lines=1 --color=pointer:magenta --color=border:'#1D2021' --footer="System" --color=footer:italic:yellow --header-border=line --footer-border=line) in
"Manage snapshots")
  urxvtc -e sh -c "sudo btrfs-assistant"
  exit
  ;;
"Clean up system")
  urxvtc -e sh -c "moonbit"
  exit
  ;;
"CachyOS Hello")
  cachyos-hello
  exit
  ;;
"Monitor system")
  urxvtc -g 120x35 -e sh -c "btop"
  exit
  ;;
*)
  exit
  ;;
esac
