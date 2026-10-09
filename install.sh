#!/bin/sh

if [ "$EUID" -eq 0 ]; then
   echo "You are root. Run this installation script as normal user."
   exit
fi

stow -R -v -d user-stow -t ~ bash
stow -R -v -d user-stow -t ~/.config config
stow -R -v -d user-stow -t ~/.local/bin local-bin
stow -R -v -d user-stow -t ~/.vim vim
