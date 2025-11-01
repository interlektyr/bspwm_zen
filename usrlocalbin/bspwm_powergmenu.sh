#!/bin/bash

echo "Lock" > /tmp/optionsP.txt
echo "Shutdown" >> /tmp/optionsP.txt
echo "Reload X11" >> /tmp/optionsP.txt
echo "Reboot" >> /tmp/optionsP.txt
echo "Reboot into firmware" >> /tmp/optionsP.txt
echo "Cancel" >> /tmp/optionsP.txt

case $(cat /tmp/optionsP.txt | gum filter --header="Power options") in
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
