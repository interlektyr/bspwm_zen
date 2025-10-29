#!/usr/bin/env bash

clockbar() {

  TIME=$(date "+%H:%M")
  echo -e -n "%{c}$TIME"
  sleep 2.0s

}

clockbar | lemonbar -n clockbar -b -d -g 135x50+10+10 -F#1d2021 -B#D3C6AA -o 0 -f "DepartureMonoNerdFont-18" >/dev/null 2>&1
