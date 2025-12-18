#!/bin/sh

if [ "$(curl -Is http://www.google.com | head -n 1 | grep OK)" ]; then
  con="Connected"
else
  con="Disconected"
fi

if [ "$(cat /etc/ufw/ufw.conf | grep ENABLED=yes)" = "ENABLED=yes" ]; then
  ufw="UP"
else
  ufw="DOWN"
fi

if [ "$(mullvad status | grep Connected)" ]; then
  vpn="ON"
else
  vpn="OFF"
fi

case $(echo -e "enter select  esc exit\nInternet: ($con)\nFirewall: ($ufw)\nVPN: ($vpn)\nBluetooth\nStart torrent-client\nStop torrent-client" | fzf --info=hidden --header-lines=1 --color=pointer:magenta --color=border:'#1D2021' --footer="Connections" --color=footer:italic:yellow --header-border=line --footer-border=line) in
"Internet: ($con)")
  urxvtc -g 100x40 -e sh -c "nmtui"
  exit
  ;;
"Firewall: ($ufw)")
  urxvtc -g 120x24 -e sh -c "sudo tufw"
  exit
  ;;
"VPN: ($vpn)")
  mullvad status
  ;;
"Bluetooth")
  urxvtc -e sh -c "bluetuith"
  exit
  ;;
"Start torrent-client")
  transmission-daemon
  urxvtc -e sh -c "tremc"
  exit
  ;;
"Stop torrent-client")
  transmission-remote --exit
  exit
  ;;
"Cancel")
  exit
  ;;
*)
  exit
  ;;
esac
