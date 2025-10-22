#!/bin/bash

next_wc () {
#bspc desktop -f next.local
bspc desktop -f next.local
set_wc
}

prev_wc () {
bspc desktop -f prev.local
set_wc 
}

jump_wc () {
bspc desktop --focus "^${selwc}"
set_wc
}

set_wc () {
xrandr -q | grep "DP-1-1 connected" && cw=$(bspc query -d 'DP-1-1:focused' -D --names)
xrandr -q | grep "DP-1-1 connected" || cw=$(bspc query -D -d focused --names)
sel=$(sed -n "${cw}p" < /tmp/randwall.txt)
hsetroot -cover $sel
#dunstify -h string:x-dunst-stack-tag:wc "Desktop $cw" -i 1
}

send_wc () {
bspc node --to-desktop "^${sendwc}"
dunstify -i /$HOME/.config/bspwm/bspwm_logo.svg -h string:x-dunst-stack-tag:wc "Window was sent to Desktop $sendwc"
}

case $1 in
    next)
    next_wc;;
    prev)
    prev_wc;;
    jump)
    selwc=$2
    jump_wc;;
    send)
    sendwc=$2
    send_wc;;
    *)
    exit;;
esac
