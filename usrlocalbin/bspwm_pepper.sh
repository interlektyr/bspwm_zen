#!/bin/bash

update() {

  echo "Checking for updates (pacman)..."

  nopkmn=$(
    gum spin --spinner pulse --title "Checking for updates (pacman)" --show-output -- checkupdates | wc -l
    #echo "Checking for updates (pacman): done"
  )

  echo "Checking for updates (pacman)... done!"
  echo "Checking for upates (AUR)..."

  noaur=$(
    gum spin --spinner pulse --title "Checking for updates (AUR)" --show-output -- pacman -Qm | aur vercmp | wc -l
    #echo "Checking for updates (AUR): done"
  )

  echo "Checking for updates (AUR)... done!"

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
      up_line=$(echo -e "\e[0;32mThe system is up to date\e[0m")
    else
      up_line=$(echo -e "\e[0;31mUpdates available\e[0m ctrl-a update AUR ($noaur $anol)")
    fi
  else
    if [ "$noaur" -lt 1 ]; then
      up_line=$(echo -e "\e[0;31mUpdates available\e[0m ctrl-p update 󰮯 ($nopkmn $pnol)")
    else
      up_line=$(echo -e "\e[0;31mUpdates available\e[0m ctrl-a update 󰮯 ($nopkmn $pnol) + AUR ($noaur $anol)")
    fi
  fi

  echo "$up_line" >/tmp/pepper_ulist.txt

}

sync() {

  if [ -f /$HOME/.cache/pepper/bspwm_applist.txt ]; then
    rm /$HOME/.cache/pepper/bspwm_applist.txt
  fi

  touch /$HOME/.cache/pepper/bspwm_applist.txt

  echo "Syncking pacman repo-lists..."
  sudo pacman -Sy >/dev/null

  echo " enter install  ? show keybindings  esc exit" >/$HOME/.cache/pepper/bspwm_applist.txt

  pacman -Sl $(pacman-conf --repo-list) >>/$HOME/.cache/pepper/bspwm_applist.txt
  echo "Syncing pacman repo-lists... done!"

  echo "Syncking AUR-list..."

  if [ -f /$HOME/.cache/pepper/packages.gz ]; then
    rm /$HOME/.cache/pepper/packages.gz
  fi

  wget -q https://aur.archlinux.org/packages.gz -P /$HOME/.cache/pepper/

  for aurapps in $(zcat /$HOME/.cache/pepper/packages.gz); do
    echo "AUR $aurapps" >>/$HOME/.cache/pepper/bspwm_applist.txt
  done
  echo "Syncking AUR-list...done!"
}

main() {

  clear

  if [ ! -f /$HOME/.cache/pepper/bspwm_applist.txt ]; then
    mkdir /$HOME/.cache/pepper/
    touch /$HOME/.cache/pepper/bspwm_applist.txt
    sync
  fi

  if [ ! -f /tmp/pepper_ulist.txt ]; then
    touch /tmp/pepper_ulist.txt
  fi

  if [ -f /tmp/pepperlist.txt ]; then
    rm /tmp/pepperlist.txt
  fi

  touch /tmp/pepperlist.txt

  cat /$HOME/.cache/pepper/bspwm_applist.txt | fzf --sync --footer-border=line --info=hidden --ansi --bind "ctrl-u:execute(bspwm_pepper.sh -u)+change-footer($(echo -e $(cat /tmp/pepper_ulist.txt)))" --bind "ctrl-a:execute(paru)+execute(bspwm_pepper.sh -u)+change-footer($(echo -e $(cat /tmp/pepper_ulist.txt)))+reload(bspwm_pepper.sh)" --bind "ctrl-p:execute(sudo pacman -Syu)+execute(bspwm_pepper.sh -u)+change-footer($(echo -e $(cat /tmp/pepper_ulist.txt)))" --bind "ctrl-s:execute(bspwm_pepper.sh -s)" --multi --header-lines=1 --header-border=line --border --padding=5%,0%,0%,0% --border-label=" Pepper - helper script for pacman/paru " --footer="$up_line" --color=label:italic:yellow --color=border:'#1D2021' --color=pointer:magenta --color=marker:green | awk '{print $2}' >/tmp/pepperlist.txt

  for appn in $(cat /tmp/pepperlist.txt); do
    final+=" $appn"
  done

  paru -S $final
  appcommander.sh u
}

case $1 in
-s)
  sync
  ;;
-u)
  update
  ;;
*)
  up_line="Check for updates (ctrl+u)"
  main
  ;;
esac

#--bind "ctrl-u:change-footer($(./bspwm_pepper.sh -u))"
