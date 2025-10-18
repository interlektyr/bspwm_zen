#!/bin/bash

InV () {
pamixer -i 5;
SLen=1;
BarOut
}

DeV () {
pamixer -d 5;
SLen=1;
BarOut
}

MutV() {
pamixer -t;
SLen=1;
BarOut
}

ShoV() {
SLen=2;
BarOut
}

BarOut () {
 if [ "$(pamixer --get-volume-human)" = "muted" ]; then
  BarString() {
  echo -e -n "%{c}$(pamixer --get-volume-human)";
  sleep $SLen;
  }
 else
  BarString() {
  echo -e -n "%{c}VOL$(pamixer --get-volume-human)";
  sleep $SLen;
  }
 fi
 
BarString | lemonbar -b -d -g 90x40+110+10 -F#1d2021 -B#ebcb8b -o 0 -f "DepartureMonoNerdFont-10" >/dev/null 2>&1;
}

"$@"
