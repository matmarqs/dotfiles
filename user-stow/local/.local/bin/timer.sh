#!/bin/bash

BELL="/home/sekai/Music/bell.wav"

alarm() {
   notify-send -t 5000 "$1" && aplay "$BELL"
}

daemon_mode() {
   TIME=$((5*60))  # 5 min = 5 * 60 s
   [ -n "$1" ] && TIME=$(($1*60+10)) # if there is argument $1, convert time in minutes to seconds. also add 10 seconds offset
   echo "Sleeping for $TIME seconds."
   sleep "$TIME"
   alarm "It is time to get back to work." > /dev/null 2>&1
}

daemon_mode "$1" </dev/null >/dev/null 2>&1 &
disown
