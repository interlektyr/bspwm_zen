#!/bin/bash

sudo pacman -Sy >/dev/null
echo "Syncing repo-list: done"

if [ -f /$HOME/.config/bspwm/packages.gz ]; then
  rm /$HOME/.config/bspwm/packages.gz
fi

gum spin --spinner pulse --title "Syncing AUR" -- wget -q https://aur.archlinux.org/packages.gz -P /$HOME/.config/bspwm/ >/dev/null
echo "Syncking AUR: done"

nopkmn=$(
  gum spin --spinner pulse --title "Checking for updates (pacman)" --show-output -- checkupdates | wc -l
  #echo "Checking for updates (pacman): done"
)

echo "Checking for updates (pacman): done"

noaur=$(
  gum spin --spinner pulse --title "Checking for updates (AUR)" --show-output -- pacman -Qm | aur vercmp | wc -l
  #echo "Checking for updates (AUR): done"
)

echo "Checking for updates (AUR): done"

if [ "$nopkmn" -gt 1 ]; then
  pnol="pkgs"
else
  pnol="pkg"
fi

if [ "$noaur" -gt 1 ]; then
  anol="pkgs"
else
  anol="pkg"
fi

if [ "$nopkmn" -lt 1 ]; then
  if [ "$noaur" -lt 1 ]; then
    up_line="The system is up to date"
  else
    up_line="ctrl-a update AUR ($noaur $anol)"
  fi
else
  if [ "$noaur" -lt 1 ]; then
    up_line="ctrl-p update 󰮯 ($nopkmn $pnol)"
  else
    up_line="ctrl-{p update 󰮯 ($nopkmn $pnol)/a + AUR ($noaur $anol)}"
  fi
fi

echo "enter install | shift multi-select | $up_line | esc exit" >/$HOME/.config/bspwm/bspwm_applist.txt

pacman -Sl $(pacman-conf --repo-list) >>/$HOME/.config/bspwm/bspwm_applist.txt

for aurapps in $(zcat /$HOME/.config/bspwm/packages.gz); do
  echo "AUR $aurapps" >>/$HOME/.config/bspwm/bspwm_applist.txt
done

cat /$HOME/.config/bspwm/bspwm_applist.txt | fzf --bind "ctrl-a:execute(paru)" --bind "ctrl-p:execute(sudo pacman -Syu)" --multi --layout=reverse-list --header-lines=1 --border --padding=5%,0%,0%,0% --border-label=" Pepper - helper script for pacman/paru " --color=label:italic:yellow --color=border:'#1D2021' --color=pointer:magenta --color=marker:green | awk '{print $2}' >/tmp/pepperlist.txt

for appn in $(cat /tmp/pepperlist.txt); do
  final+=" $appn"
done

paru -S $final
appcommander.sh u
