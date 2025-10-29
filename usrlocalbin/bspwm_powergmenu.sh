#!/bin/bash

echo "Lock" > /tmp/options.txt
echo "Shutdown" >> /tmp/options.txt
echo "Reload X11" >> /tmp/options.txt
echo "Reboot" >> /tmp/options.txt
echo "Reboot into firmware" >> /tmp/options.txt
echo "Cancel" >> /tmp/options.txt

case $(cat /tmp/options.txt | gum filter --header="Power options") in
    "Lock")
    slock;;
    "Shutdown")
    gum confirm && shutdown -h now || exit;;
    "Reload X11")
    gum confirm && bspc quit || exit;;
    "Reboot")
    gum confirm && systemctl reboot || exit;;
    "Reboot into firmware")
    gum confirm && systemctl reboot --firmware-setup || exit;;
    "Cancel")
    exit;;
    *)
    exit;;
esac
