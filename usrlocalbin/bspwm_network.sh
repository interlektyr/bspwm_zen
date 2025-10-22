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

echo "Internet: $con" > ~/options.txt
echo "Firewall: $ufw (ufw)" >> ~/options.txt
echo "VPN: $vpn (mullvad)" >> ~/options.txt
echo "Cancel" >> ~/options.txt

case $(cat ~/options.txt | gum filter --header="Network options") in
    "Internet: $con")
    urxvtc -g 100x40 -e sh -c "nmtui"
    exit;;
    "Firewall: $ufw (ufw)")
    urxvtc -g 120x24 -e sh -c "sudo tufw"
    exit;;
    "VPN: $vpn (mullvad)")
    mullvad status;;
    "Cancel")
    exit;;
    *)
    exit;;
esac
