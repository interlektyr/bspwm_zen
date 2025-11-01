#!/bin/bash

#ids=($(bspc query -N -n .hidden.window))

init() {
touch /tmp/hwlist.txt
touch /tmp/hwidlist.txt
exit
}

main() {
truncate -s 0 /tmp/hwlist.txt
truncate -s 0 /tmp/hwidlist.txt
n=0
      
for wid in $(bspc query -N -n .hidden.window); do
    n=$((n+1))
    echo $wid >> /tmp/hwidlist.txt
    echo "$n: $(xprop -notype -id $wid WM_NAME | cut -d'"' -f2) | $(xprop -notype -id $wid WM_CLASS | cut -d'"' -f2)" >> /tmp/hwlist.txt
done 

if [ $n = 0 ]; then
echo "Found no windows hidden by user"
sleep 1
exit
fi

v=$(gum filter --header "Hidden windows" < /tmp/hwlist.txt | cut -d: -f1)

sel=$(sed -n "${v}p" < /tmp/hwidlist.txt)

bspc node $sel -g hidden=off -f; bspc node $sel -g sticky=off -f

exit 0
}

case $1 in
    init)
    init;;
    *)
    main;;
esac

