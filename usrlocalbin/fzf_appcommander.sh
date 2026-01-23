#!/bin/bash

check_tmp() {

  if [ ! -f /tmp/fzf_appcommander/fac_list.txt ]; then
    mkdir /tmp/fzf_appcommander/
    touch /tmp/fzf_appcommander/fac_list.txt
    touch /tmp/fzf_appcommander/nac_list.txt
    update
  fi

}

update() {

  if [ ! -f /tmp/fzf_appcommander/fac_list.txt ]; then
    check_tmp
  else
    truncate -s 0 /tmp/fzf_appcommander/fac_list.txt
    truncate -s 0 /tmp/fzf_appcommander/nac_list.txt
  fi

  echo " enter launch  ctrl-s sync  esc quit" >>/tmp/fzf_appcommander/nac_list.txt
  echo "null" >>/tmp/fzf_appcommander/fac_list.txt

  echo "Syncing .desktop-files found in /usr/share/applications..."

  for entry in $(find /usr/share/applications -name "*.desktop"); do

    d_ent="$(grep -m 1 '^Exec=' $entry | head -1 | cut -d= -f2 | awk '{print $1}')"

    if grep -qwF "$d_ent" "/tmp/fzf_appcommander/fac_list.txt"; then
      continue
    else

      namea=$(grep -m 1 '^Name=' $entry | head -1 | cut -d= -f2)

      hterm=$(grep '^Terminal=' $entry | head -1 | cut -d= -f2)

      echo "$hterm $d_ent" >>/tmp/fzf_appcommander/fac_list.txt
      echo "$namea" >>/tmp/fzf_appcommander/nac_list.txt

    fi

  done

  echo "Syncing .desktop-files found in /usr/share/applications...done!"

}

main() {

  truncate -s 0 ~/nohup.out

  check_tmp

  v=$(cat /tmp/fzf_appcommander/nac_list.txt | fzf --bind "ctrl-s:execute(fzf_appcommander.sh -u)+become(fzf_appcommander.sh)" --info=hidden --header-lines=1 --border --padding=5%,0%,0%,0% --border-label=" AppCommander custom launcher script " --border-label-pos=3 --color=label:italic:yellow --color=border:'#1D2021' --color=pointer:magenta --color=marker:green --header-border=line --footer-border=line)

  if [ -z "$v" ]; then
    exit
  fi

  lineNum=$(grep -n "$v" "/tmp/fzf_appcommander/nac_list.txt" | cut -d: -f1)

  #selex=$(sed -n "${lineNum}p" </tmp/fzf_appcommander/fac_list.txt)

  checkterm=$(sed -n "${lineNum}p" </tmp/fzf_appcommander/fac_list.txt | awk '{print $1}')

  sel=$(sed -n "${lineNum}p" </tmp/fzf_appcommander/fac_list.txt | awk '{print $2}')

  #sel="$($selex | awk '{print $2}')"

  if [ "$checkterm" = "false" ]; then

    #sel=$($selex | awk '{print $2}')

    launch $sel

    exit 0

  else

    #nohup wezterm start $sel;exit
    nohup urxvtc -g 150x50 -e sh -c "$sel;exit"

    exit 0

  fi

}

case $1 in
-u)
  update
  ;;
*)
  main
  ;;
esac
