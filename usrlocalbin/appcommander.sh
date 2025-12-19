#!/bin/bash

update() {

  truncate -s 0 /tmp/appcommander/AC_Exec.txt
  truncate -s 0 /tmp/appcommander/AC_Name.txt
  truncate -s 0 /tmp/appcommander/AC_Term.txt

  echo " enter launch  ctrl-s sync  esc quit" >>/tmp/appcommander/AC_Name.txt
  echo "null" >>/tmp/appcommander/AC_Exec.txt
  echo "null" >>/tmp/appcommander/AC_Term.txt

  echo "Syncing .desktop-files found in /usr/share/applications..."

  for entry in $(find /usr/share/applications -name "*.desktop"); do
    onlyname=$(echo $entry | cut -d/ -f5)
    echo "$entry" >>/tmp/appcommander/AC_Exec.txt
    nameApp=$(grep -m 1 '^Name=' $entry | head -1 | cut -d= -f2)

    if grep -qwF "$nameApp" "/tmp/appcommander/AC_Name.txt"; then
      echo "$nameApp ($onlyname)" >>/tmp/appcommander/AC_Name.txt
    else
      echo "$nameApp" >>/tmp/appcommander/AC_Name.txt
    fi

    hterm=$(grep '^Terminal=' $entry | head -1 | cut -d= -f2)

    if [ "$hterm" = "true" ]; then
      echo "$(grep -m 1 '^Exec=' $entry | head -1 | cut -d= -f2)" >>/tmp/appcommander/AC_Term.txt
    else
      echo "false" >>/tmp/appcommander/AC_Term.txt
    fi

  done

  echo "Syncing .desktop-files found in /usr/share/applications...done!"

}

main() {

  truncate -s 0 ~/nohup.out

  if [ ! -f /tmp/appcommander/AC_Exec.txt] || [ ! -f /tmp/appcommander/AC_Name.txt] || [ ! -f /tmp/appcommander/AC_Term.txt]; then
    mkdir /tmp/appcommander/
    touch /tmp/appcommander/AC_Exec.txt
    touch /tmp/appcommander/AC_Name.txt
    touch /tmp/appcommander/AC_Term.txt
    update
  fi

  v=$(cat /tmp/appcommander/AC_Name.txt | fzf --bind "ctrl-s:execute(appcommander.sh u)+become(appcommander.sh)" --info=hidden --header-lines=1 --border --padding=5%,0%,0%,0% --border-label=" AppCommander custom launcher script " --border-label-pos=3 --color=label:italic:yellow --color=border:'#1D2021' --color=pointer:magenta --color=marker:green --header-border=line --footer-border=line)

  lineNum=$(grep -n "$v" "/tmp/appcommander/AC_Name.txt" | cut -d: -f1)

  checkterm=$(sed -n "${lineNum}p" </tmp/appcommander/AC_Term.txt)

  if [ "$checkterm" = "false" ]; then

    sel=$(sed -n "${lineNum}p" </tmp/appcommander/AC_Exec.txt)

    nohup dex $sel >/dev/null 2>&1

    exit 0

  else

    nohup urxvtc -g 150x50 -e sh -c "$checkterm;exit"

    exit 0

  fi

}

case $1 in
u)
  update
  ;;
*)
  main
  ;;
esac
