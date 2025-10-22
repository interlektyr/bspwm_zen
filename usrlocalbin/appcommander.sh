#!/bin/bash

init_ac() {
touch /tmp/ac_applist.txt
exit
}

main_ac() {
truncate -s 0 /tmp/ac_applist.txt
truncate -s 0 ~/nohup.out

ls -p /usr/share/applications | grep -v / | sed 's/\.[^.]*$//' > /tmp/ac_applist.txt

sel="$(gum filter < /tmp/ac_applist.txt).desktop"

nohup dex /usr/share/applications/$sel > /dev/null 2>&1

exit 0

}

case $1 in
    init)
    init_ac;;
    *)
    main_ac;;
esac

