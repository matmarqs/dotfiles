#!/bin/sh

# Ensure the script is run with root privileges
if [ "$(id -u)" -eq 0 ]; then
    echo "You are root. Run this installation script as normal user." >&2
    exit 1
fi

stow -R -v -d user-stow -t ~ bash
stow -R -v -d user-stow -t ~/.config config
stow -R -v -d user-stow -t ~/.local/bin local-bin
stow -R -v -d user-stow -t ~/.vim vim

sudo stow -R -v -d system-stow -t /usr/local usr-local
sudo stow -R -v -d system-stow -t /root root
sudo stow -R -v -d system-stow -t /etc etc
