#!/bin/bash
chosenwal='touka-contrast.png'
curdir=`dirname "$(realpath $0)"`
wal -i $HOME/Pictures/Wallpapers/$chosenwal
cp $HOME/.cache/wal/colors $curdir
python st-color.py
