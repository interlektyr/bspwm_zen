#!/bin/bash

truncate -s 0 /tmp/appcommander/AC_Exec.txt
truncate -s 0 /tmp/appcommander/AC_Name.txt
truncate -s 0 /tmp/appcommander/AC_Term.txt
truncate -s 0 ~/nohup.out
x=0

for entry in $(find /usr/share/applications -name "*.desktop"); do
  x=$((x + 1))
  echo "$entry" >>/tmp/appcommander/AC_Exec.txt
  echo "$x: $(grep -m 1 '^Name=' $entry | head -1 | cut -d= -f2)" >>/tmp/appcommander/AC_Name.txt
  hterm=$(grep '^Terminal=' $entry | head -1 | cut -d= -f2)

  if [ "$hterm" = "true" ]; then

    termex=$(grep -m 1 '^Exec=' $entry | head -1 | cut -d= -f2)
    echo $termex >>/tmp/appcommander/AC_Term.txt

  else

    echo $hterm >>/tmp/appcommander/AC_Term.txt

  fi

done

v=$(gum filter --header "AppCommander custom launcher script" </tmp/appcommander/AC_Name.txt | cut -d: -f1)

checkterm=$(sed -n "${v}p" </tmp/appcommander/AC_Term.txt)

if [ "$checkterm" = "false" ]; then

  sel=$(sed -n "${v}p" </tmp/appcommander/AC_Exec.txt)

  nohup dex $sel >/dev/null 2>&1

  exit 0

else

  nohup urxvtc -g 150x50 -e sh -c "$checkterm;exit"

  exit 0

fi
