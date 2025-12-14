#!/bin/sh

echo " enter select  esc exit" >~/options.txt
echo "Manage snapshots" >>~/options.txt
echo "Clean up system" >>~/options.txt
echo "CachyOS Hello" >>~/options.txt
echo "Monitor system" >>~/options.txt
echo "Cancel" >>~/options.txt

case $(cat ~/options.txt | fzf --layout=reverse-list --header-lines=1 --border --padding=5%,0%,0%,0% --border-label=" System " --color=label:italic:yellow --color=border:'#1D2021' --color=pointer:magenta --color=marker:green) in
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
