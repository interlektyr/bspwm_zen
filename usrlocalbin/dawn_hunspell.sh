#!/bin/bash

if [ ! -f /tmp/dawn_tmp.txt ]; then
  touch /tmp/dawn_tmp.txt
fi

truncate -s 0 /tmp/dawn_tmp.txt

xsel --clipboard --trim >/tmp/dawn_tmp.txt

hunspell -d sv_SE /tmp/dawn_tmp.txt

cat /tmp/dawn_tmp.txt | xsel -b --trim

exit 0
