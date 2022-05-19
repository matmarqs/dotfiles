#!/bin/bash
chosenwal='Avatars/champloo-avatar.png'
curdir=`dirname "$(realpath $0)"`
wal -i $HOME/pictures/$chosenwal
cp $HOME/.cache/wal/colors $curdir
python st-color.py
