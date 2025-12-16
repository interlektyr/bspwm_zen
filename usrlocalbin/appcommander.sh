#!/bin/bash

update() {

  truncate -s 0 /tmp/appcommander/AC_Exec.txt
  truncate -s 0 /tmp/appcommander/AC_Name.txt
  truncate -s 0 /tmp/appcommander/AC_Term.txt

  echo " enter launch  esc quit" >>/tmp/appcommander/AC_Name.txt
  echo "null" >>/tmp/appcommander/AC_Exec.txt
  echo "null" >>/tmp/appcommander/AC_Term.txt

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

}

main() {

  truncate -s 0 ~/nohup.out

  v=$(cat /tmp/appcommander/AC_Name.txt | fzf --info=hidden --header-lines=1 --border --padding=5%,0%,0%,0% --border-label=" AppCommander custom launcher script " --border-label-pos=3 --color=label:italic:yellow --color=border:'#1D2021' --color=pointer:magenta --color=marker:green --header-border=line --footer-border=line)

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
