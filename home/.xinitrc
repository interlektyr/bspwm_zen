#!/bin/sh

export SXHKD_SHELL=/usr/bin/bash
export PAGER=moore
export VISUAL=neovide
export EDITOR=neovide
export RANGER_LOAD_DEFAULT_RC=false
export _JAVA_AWT_WM_NONREPARENTING=1

xrdb /home/kristian/.Xresources &
xrdb -merge ~/.Xresources

exec bspwm
