#!/bin/bash

increase_s () {
wpctl set-volume -l 1.5 61 5%+
show_s
} 

decrease_s () {
wpctl set-volume 61 5%-
show_s
}

show_s () {
curr_w=$(wpctl get-volume 61 | cut -d '.' -f 2) 
dunstify -i /$HOME/.config/bspwm/bspwm_logo.svg -h string:x-dunst-stack-tag:soundc "Volume: $curr_w%"
}

case $1 in
    h)
    increase_s;;
    l)
    decrease_s;;
    s)
    show_s;;
    *)
    exit;;
esac
