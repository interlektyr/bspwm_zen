#!/bin/sh

if [ "$(curl -Is  http://www.google.com | head -n 1 | grep OK)" ]; then
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

echo "Internet: $con" > /tmp/optionsN.txt
echo "Firewall: $ufw (ufw)" >> /tmp/optionsN.txt
echo "VPN: $vpn (mullvad)" >> /tmp/optionsN.txt
echo "Bluetooth (bluetuith)" >> /tmp/optionsN.txt
echo "Start Torrents (tremc)" >> /tmp/optionsN.txt
echo "Stop Torrents (transmission-remote)" >> /tmp/optionsN.txt
echo "Cancel" >> /tmp/optionsN.txt

case $(cat /tmp/optionsN.txt | gum filter --header="Connections") in
    "Internet: $con")
    urxvtc -g 100x40 -e sh -c "nmtui"
    exit;;
    "Firewall: $ufw (ufw)")
    urxvtc -g 120x24 -e sh -c "sudo tufw"
    exit;;
    "VPN: $vpn (mullvad)")
    mullvad status;;
    "Bluetooth (bluetuith)")
    urxvtc -e sh -c "bluetuith"
    exit;;
    "Start Torrents (tremc)")
    transmission-daemon;
    urxvtc -e sh -c "tremc"
    exit;;
    "Stop Torrents (transmission-remote)")
    transmission-remote --exit;
    exit;;
    "Cancel")
    exit;;
    *)
    exit;;
esac
