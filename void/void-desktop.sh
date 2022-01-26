#!/bin/bash

# This script should only be executed in a FRESH Void Linux install.

## This install script assumes the following:
# 0. You are on Void Linux and have the following packages installed:
#    base-system, base-devel, sudo, git
# 1. The base installation was already done.
# 2. The script was executed as a normal user (NOT root).
# 3. The script is inside its git directory, which has all the original files.
# 4. The script will copy all the config files to each path. This means that
#    YOUR CONFIGS WILL BE OVERWRITTEN. Please make a backup of them.
# 5. The following programs need to be configured manually:
#    fcitx-configtool, nvim (vim-plug, TSUpdate)

getUsage () {
    echo -ne "\nDo you plan to use this system as desktop (d) or virtual machine (v)? [d/v] "
    read USAGE
    [ ! $USAGE == "d" ] && [ ! $USAGE == "v" ] && getUsage
}

echo -e "\nYou can check the deps directory for dependencies.\n"
echo -n "Your config files will be overwritten. Type \"y\" to continue. [y/n] "
read CONTINUE
[ $CONTINUE != "y" ] && exit
echo -e "\n"

echo -e "\nChanging to the best repository I know, upgrading and adding non-free repository.\n"
echo "repository=https://mirrors.servercentral.com/voidlinux/current" > /usr/share/xbps.d/00-repository-main.conf
sudo xbps-install -Syu && sudo xbps-install -yu void-repo-nonfree # 2 times in case xbps needs to be updated
echo "repository=https://mirrors.servercentral.com/voidlinux/current" > /usr/share/xbps.d/10-repository-nonfree.conf
echo -e "\n"

THEUSER=$(whoami)
DOTDIR=$(dirname "$(realpath $0)")
MYDEPS=$(cat $DOTDIR/dependencies.txt)

echo -e "\nInstalling dependencies with xbps.\n"
sudo xbps-install -y $MYDEPS
echo -e "\n"

echo -e "\nCopying all \"house\" files to \$HOME.\n"
cp -r $DOTDIR/house/. $HOME
echo -e "\n"

echo -e "\nCopying all \"etc\" files to /etc.\n"
sudo cp -r $DOTDIR/etc/. /etc
echo -e "\n"

echo -e "\nCopying all \"usr\" files to /usr.\n"
sudo cp -r $DOTDIR/usr/. /usr
echo -e "\n"

# Veryfing if DESKTOP or VIRTUAL
if [ $USAGE == "d" ]; then
    cp -r $DOTDIR/desktop/house/. $HOME
else
    cp -r $DOTDIR/virtual/house/. $HOME
    cp -r $DOTDIR/virtual/etc/. /etc
fi

# making scripts executable
echo -e "\nMaking scripts executable.\n"
sudo chmod -R +x /usr/local/scripts
sudo chmod -R +x /usr/local/bin
chmod -R +x "$HOME/.config/sxiv/exec"
chmod +x "$HOME/.config/dynconf/aesthetics"
echo -e "\n"

# getting rid of delay in bash vi-mode by /etc/inputrc
echo -e "\nGetting rid of delay in bash vi mode by /etc/inputrc.\n"
echo -e "\n# no delay in bash vi-mode\nset keyseq-timeout 0.01" | sudo tee -a /etc/inputrc
echo -e "\n"

# configuring /etc/sudoers
echo -e "\nAdding some lines to sudoers for some convenient commands.\n"
echo -e "\n## Giving permissions of some commands to the user\nCmnd_Alias SHUTDOWN_CMDS = /bin/poweroff, /bin/reboot, /bin/zzz\nCmnd_Alias NET_CMDS = /usr/local/bin/netrestart\n$THEUSER ALL = NOPASSWD: SHUTDOWN_CMDS, NET_CMDS" | sudo EDITOR='tee -a' visudo
echo -e "\n"

echo -e "\nSetting up crontab.\n"
sudo ln -sf /etc/sv/cronie /var/service
echo -e "# change light/dark theme\n15 18 * * * DISPLAY=:0 \$HOME/.config/dynconf/aesthetics\n15 07 * * * DISPLAY=:0 \$HOME/.config/dynconf/aesthetics\n# low battery notification\n*/10 * * * * DISPLAY=:0 /usr/local/scripts/lowbat" | sudo tee /var/spool/cron/$THEUSER
echo -e "\n"

echo -e "\nConfiguring GTK and Qt themes.\n"
mkdir -p "$HOME/.config/gtk-2.0"; mkdir -p "$HOME/.config/gtk-3.0"
echo "\n"

# extracting resources
echo -e "\nExtracting appearance resources.\n"
sudo tar -xzf $HOME/.local/appearance/BeautyLine/BeautyLine.tar.gz -C /usr/share/icons
sudo tar -xzf $HOME/.local/appearance/Midnight-BlueNight/Midnight-BlueNight.tar.gz -C /usr/share/themes
sudo tar -xf $HOME/.local/appearance/Sweet-Ambar-Blue/Sweet-Ambar-Blue.tar.xz -C /usr/share/themes
sudo tar -xf $HOME/.local/appearance/Matcha-sea/Matcha-sea.tar.xz -C /usr/share/themes
sudo unzip -qq $HOME/.local/appearance/mononoki/mononoki.zip -d /usr/share/fonts
echo -e "\n"

echo -e "\nChanging default cursor theme to Breeze_Hacked.\n"
echo -e "[icon theme]\nInherits=Breeze_Hacked" | sudo tee /usr/share/icons/default/index.theme
echo -e "\n"

# compiling and installing suckless programs
echo -e "\nCompiling and installing dwm.\n"
cd $HOME/.local/dwm
ln -sf config.def.h config.h
sudo make -s clean install
echo -e "\n"
echo -e "\nCompiling and installing st.\n"
cd $HOME/.local/st
ln -sf config.def.h config.h
sudo make -s clean install
echo -e "\n"
echo -e "\nCompiling and installing dwmblocks.\n"
cd $HOME/.local/dwmblocks
ln -sf blocks.def.h blocks.h
sudo make -s clean install
echo -e "\n"
cd $DOTDIR

echo -e "\nCreating basic home folders.\n"
mkdir -p $HOME/Music
mkdir -p $HOME/Documents
mkdir -p $HOME/Workspace
mkdir -p $HOME/downloads
mkdir -p $HOME/pictures/prints
mkdir -p $HOME/pictures/wallpapers
mkdir -p $HOME/Videos
mkdir -p $HOME/.local/public
echo -e "\n"

echo -e "\nCreating mpd folders.\n"
mkdir -p $HOME/.local/share/mpd/playlists
mkdir -p $HOME/.local/share/lyrics
echo -e "\n"

echo -e "\nFixing the fonts.\n"
sudo ln -sf /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d && sudo xbps-reconfigure -f fontconfig
echo -e "\n"

echo -e "\nUpdating Xresources.\n"
xrdb $HOME/.config/x11/Xresources
echo -e "\n"

echo -e "\nSetting some files for root.\n"
sudo cp $DOTDIR/house/.bashrc /root
sudo cp $DOTDIR/house/.bash_profile /root
sudo cp -r $DOTDIR/house/.vim /root
mkdir -p /root/.config/shell
sudo cp -r $DOTDIR/.config/shell /root/.config
sudo cp -r $DOTDIR/.config/tmux /root/.config
sudo cp -r $DOTDIR/.config/wget /root/.config
echo -e "\n"

# choice for installing some of my desktop/dev tools
