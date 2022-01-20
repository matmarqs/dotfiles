#!/bin/bash

# This script should only be executed in a FRESH Arch Linux install.

## This install script assumes the following:
# 0. You are on Arch Linux and have the following packages installed:
#    base, base-devel, sudo, git
# 1. The base installation was already done. With locales en_US and ja_JP available.
# 2. The script was executed as a normal user (NOT root).
# 3. The script is inside its git directory, which has all the original files.
# 4. The script will copy all the config files to each path. This means that
#    YOUR CONFIGS WILL BE OVERWRITTEN. Please make a backup of them.
# 5. The following programs need to be configured graphically:
#    fcitx-configtool

echo "You can check the dependencies.txt file."
echo -n "Your config files will be overwritten. Type \"y\" to continue. [y/n] "
read CONTINUE
[ $CONTINUE != "y" ] && exit

THEUSER=$(whoami)
DOTDIR=$(dirname "$(realpath $0)")
MYDEPS=$(cat $DOTDIR/dependencies.txt)

echo "Updating and upgrading the system."
sudo pacman -Syyu
echo ""

echo "Installing dependencies with sudo pacman -S."
sudo pacman -S --needed $MYDEPS
echo ""

echo "Copying all \"house\" files to \$HOME."
cp -r $DOTDIR/house/. $HOME
echo ""

echo "Copying all \"etc\" files to /etc."
sudo cp -r $DOTDIR/etc/. /etc
echo ""

echo "Copying all \"usr\" files to /usr."
sudo cp -r $DOTDIR/usr/. /usr
echo ""

# making my scripts executable
sudo chmod -R +x /usr/local/scripts
sudo chmod -R +x /usr/local/bin
chmod -R +x "$HOME/.config/sxiv/exec"

# changing tty keyboard layout to br-abnt2-custom
echo "Setting Esc and Caps_Lock changed in tty."
echo "KEYMAP=/usr/local/share/keymaps/br-abnt2-custom.map.gz" | sudo tee /etc/vconsole.conf
echo ""

# getting rid of delay in bash vi-mode by /etc/inputrc
echo "Getting rid of delay in bash vi mode by /etc/inputrc."
echo -e "\n# no delay in bash vi-mode\nset keyseq-timeout 0.01" | sudo tee -a /etc/inputrc
echo ""

# configuring /etc/sudoers
echo "Adding some lines to sudoers for some convenient commands."
echo -e "\n## Giving permissions of some commands to the user\nCmnd_Alias SHUTDOWN_CMDS = /bin/poweroff, /bin/reboot\nCmnd_Alias NET_CMDS = /usr/local/bin/netrestart\n$THEUSER ALL = NOPASSWD: SHUTDOWN_CMDS, NET_CMDS" | sudo EDITOR='tee -a' visudo
echo ""

# setting up the crontab
sudo systemctl enable cronie
echo -e "# Trocar tema para light ou dark\n15 18 * * * DISPLAY=:0 /usr/local/scripts/aesthetics\n15 07 * * * DISPLAY=:0 /usr/local/scripts/aesthetics\n# Notificacao de bateria baixa\n*/10 * * * * DISPLAY=:0 /usr/local/scripts/lowbat" | sudo tee /var/spool/cron/$THEUSER

# configuring themes for GTK and Qt
echo "Configuring GTK and Qt themes."
mkdir "$HOME/.config/gtk-2.0"; mkdir "$HOME/.config/gtk-3.0"
echo ""

# extracting resources
echo "Extracting appearance resources."
sudo tar -xzvf $HOME/.source/appearance/BeautyLine/BeautyLine.tar.gz -C /usr/share/icons
sudo tar -xzvf $HOME/.source/appearance/Midnight-BlueNight/Midnight-BlueNight.tar.gz -C /usr/share/themes
sudo tar -xvf  $HOME/.source/appearance/Sweet-Ambar-Blue/Sweet-Ambar-Blue.tar.xz -C /usr/share/themes
sudo unzip $HOME/.source/appearance/mononoki/mononoki.zip -d /usr/share/fonts
echo ""

# changing default cursor theme to Breeze_Snow
echo "Changing default cursor theme to Breeze_Snow."
echo -e "[icon theme]\nInherits=Breeze_Snow" | sudo tee /usr/share/icons/default/index.theme

# compiling and installing suckless programs
echo "Compiling and installing dwm."
cd $HOME/.source/dwm
ln -sf config.def.h config.h
sudo make clean install
echo ""
echo "Compiling and installing st."
cd $HOME/.source/st
ln -sf config.def.h config.h
sudo make clean install
echo ""
echo "Compiling and installing dwmblocks."
cd $HOME/.source/dwmblocks
ln -sf blocks.def.h blocks.h
sudo make clean install
echo ""
cd $DOTDIR

# creating some basic folders
echo "Creating basic home folders."
mkdir -p $HOME/music
mkdir -p $HOME/documents
mkdir -p $HOME/Workspace
mkdir -p $HOME/Downloads
mkdir -p $HOME/pictures/prints
mkdir -p $HOME/pictures/Wallpapers
mkdir -p $HOME/Videos
echo ""

# creating folders for mpd
echo "Creating mpd folder."
mkdir -p $HOME/.local/share/mpd/playlists
echo ""
