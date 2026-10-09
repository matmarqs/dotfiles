#!/bin/sh

# when there is a break, play bell, then wait 5 min and play bell again
if [ "$POMO_STATE" = "BREAKING" ]; then
   aplay "$HOME/Music/bell.wav" && sleep 300 && aplay "$HOME/Music/bell.wav"
elif [ "$POMO_STATE" = "COMPLETE" ]; then
   aplay "$HOME/Music/bell.wav"
fi
