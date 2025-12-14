#!/bin/bash

pacman -Sl $(pacman-conf --repo-list) >/$HOME/.config/bspwm/bspwm_applist.txt

if [ -f /$HOME/.config/bspwm/packages.gz ]; then
  rm /$HOME/.config/bspwm/packages.gz
fi

gum spin --spinner pulse --title "Syncing databases" -- wget https://aur.archlinux.org/packages.gz -P /$HOME/.config/bspwm/ >/dev/null

for aurapps in $(zcat /$HOME/.config/bspwm/packages.gz); do
  echo "AUR $aurapps" >>/$HOME/.config/bspwm/bspwm_applist.txt
done

#va=$(gum filter --no-limit --header "AppInstaller" </$HOME/.config/bspwm/bspwm_applist.txt)
va=$(cat /$HOME/.config/bspwm/bspwm_applist.txt | fzf --border --border-label=" AppInstaller " --color=label:italic:yellow)

final=$(echo $va | awk '{print $2}')

paru -S $final
