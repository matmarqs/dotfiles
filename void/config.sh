#!/bin/bash

## This script should only be executed in a FRESH Void Linux install.
## The script will copy all the config files to each path. This means that
## YOUR CONFIGS WILL BE OVERWRITTEN. Please make a backup of them.

# This install script assumes the following:
# 0. You are in a FRESH Void Linux, have base-system installed and proper network connection.
# 1. The script was executed as a normal user (NOT root).
# 2. The script is inside its git directory, which has all the original files.
# 4. The following programs need to be configured manually:
#    fcitx-configtool, nvim (vim-plug, TSUpdate)

say () {
    printf "\n$1\n"
}

getAns () {
    # $1 = opt1, $2 = opt2, $3 = question, $4 = ans
    printf "\n$3 [$1/$2] "
    read _ans
    [ ! "$_ans" = "$1" ] && [ ! "$_ans" = "$2" ] && getAns "$1" "$2" "$3" "$4" || eval $4="'$_ans'" ; unset _ans
}


say "You can check deps files for dependencies."
getAns "y" "n" "Your config files will be overwritten. Continue?" "CONTINUE"
[ "$CONTINUE" != "y" ] && echo && exit
echo

getAns "d" "v" "Do you plan to use this system as desktop (d) or virtual machine (v)?" "USAGE"

# getting the variables
THEUSER=$(whoami)
DOTDIR=$(dirname "$(realpath $0)")
if [ "$USAGE" = "d" ]; then
    MYDEPS="$(cat "$DOTDIR/deps.txt" "$DOTDIR/desktop/deps-desktop.txt")"
else
    MYDEPS="$(cat "$DOTDIR/deps.txt" "$DOTDIR/virtual/deps-virtual.txt")"
fi

say "Changing to the best repository I know, upgrading and adding non-free repository."
echo "repository=https://mirrors.servercentral.com/voidlinux/current" | sudo tee /usr/share/xbps.d/00-repository-main.conf
sudo xbps-install -Syu && sudo xbps-install -yu void-repo-nonfree   # 2 times in case xbps needs to be updated
echo "repository=https://mirrors.servercentral.com/voidlinux/current" | sudo tee /usr/share/xbps.d/10-repository-nonfree.conf
echo

say "Installing dependencies with xbps."
sudo xbps-install -y "$MYDEPS"
echo

say "Copying all files to respective directories."
cp -r $DOTDIR/house/. $HOME
sudo cp -r $DOTDIR/etc/. /etc
sudo cp -r $DOTDIR/usr/. /usr
echo

# checking if DESKTOP or VIRTUAL
if [ "$USAGE" = "d" ]; then
    cp -r $DOTDIR/desktop/house/. $HOME
else
    cp -r $DOTDIR/virtual/house/. $HOME
    sudo cp -r $DOTDIR/virtual/etc/. /etc
fi

say "Making scripts executable."
sudo chmod -R +x /usr/local/scripts
sudo chmod -R +x /usr/local/bin
chmod -R +x "$HOME/.config/sxiv/exec"
chmod +x "$HOME/.config/dynconf/aesthetics"
echo

say "Adding some lines to /etc/sudoers for some convenient commands."
printf "\n## Giving permissions of some commands to the user\nCmnd_Alias SHUTDOWN_CMDS = /bin/poweroff, /bin/reboot, /bin/zzz\nCmnd_Alias NET_CMDS = /usr/local/bin/netrestart\n$THEUSER ALL = NOPASSWD: SHUTDOWN_CMDS, NET_CMDS\n" | sudo EDITOR='tee -a' visudo
echo

say "Setting up crontab."
sudo ln -sf /etc/sv/cronie /var/service
printf "# change light/dark theme\n15 18 * * * DISPLAY=:0 \$HOME/.config/dynconf/aesthetics\n15 07 * * * DISPLAY=:0 \$HOME/.config/dynconf/aesthetics\n# low battery notification\n*/10 * * * * DISPLAY=:0 /usr/local/scripts/lowbat\n" | sudo tee /var/spool/cron/$THEUSER
echo

say "Configuring GTK and Qt themes."
mkdir -p "$HOME/.config/gtk-2.0" "$HOME/.config/gtk-3.0"
echo

# extracting resources
say "Extracting appearance resources."
sudo tar -xzf $HOME/.local/appearance/BeautyLine/BeautyLine.tar.gz -C /usr/share/icons
sudo tar -xzf $HOME/.local/appearance/Midnight/Midnight-BlueNight.tar.gz -C /usr/share/themes
sudo tar -xzf $HOME/.local/appearance/Midnight/Midnight-GreenNight.tar.gz -C /usr/share/themes
sudo tar -xf $HOME/.local/appearance/Sweet-Ambar-Blue/Sweet-Ambar-Blue.tar.xz -C /usr/share/themes
sudo tar -xf $HOME/.local/appearance/Matcha-sea/Matcha-sea.tar.xz -C /usr/share/themes
sudo unzip -qq $HOME/.local/appearance/mononoki/mononoki.zip -d /usr/share/fonts
echo

say "Changing default cursor theme to Breeze_Hacked."
sudo mkdir -p /usr/share/icons/default
printf "[icon theme]\nInherits=Breeze_Hacked\n" | sudo tee /usr/share/icons/default/index.theme
echo

# compiling and installing suckless programs
say "Compiling and installing dwm."
cd $HOME/.local/dwm
ln -sf config.def.h config.h
sudo make -s clean install
echo

say "Compiling and installing st."
cd $HOME/.local/st
ln -sf config.def.h config.h
sudo make -s clean install
echo

say "Compiling and installing dwmblocks."
cd $HOME/.local/dwmblocks
ln -sf blocks.def.h blocks.h
sudo make -s clean install
echo

cd $DOTDIR

say "Creating basic home folders."
mkdir -p $HOME/.cache
mkdir -p $HOME/Music $HOME/Documents $HOME/Workspace $HOME/downloads $HOME/Pictures/prints
mkdir -p $HOME/Pictures/wallpapers $HOME/Videos $HOME/.local/public
echo

say "Creating mpd folders."
mkdir -p $HOME/.local/share/mpd/playlists $HOME/.local/share/lyrics
echo

say "Fixing the fonts."
sudo ln -sf /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d && sudo xbps-reconfigure -f fontconfig
echo

# deleting some trash from the default installation
say "Deleting residues from default installation."
[ -f $HOME/.inputrc ] && rm $HOME/.inputrc
[ -f $HOME/.lesshst ] && rm $HOME/.lesshst
[ -f $HOME/.bash_history ] && rm $HOME/.bash_history

say "Configuring some files for root."
sudo cp -r $DOTDIR/root/. /root
sudo cp -r $DOTDIR/house/.vim /root
sudo mkdir -p /root/.config
sudo mkdir -p /root/.local/bin
sudo mkdir -p /root/.local/share
sudo mkdir -p /root/.cache
sudo cp -r $DOTDIR/.config/shell /root/.config
sudo cp -r $DOTDIR/.config/tmux /root/.config
sudo cp -r $DOTDIR/.config/wget /root/.config
sudo rm /root/.inputrc
sudo rm /root/.lesshst
sudo rm /root/.bash_history
echo

say "Enabling and disabling some services."
sudo rm -rf /var/service/dhcpcd
sudo rm -rf /var/service/sshd
sudo rm -rf /var/service/acpid
sudo rm -rf /var/service/agetty-tty4
sudo rm -rf /var/service/agetty-tty5
sudo rm -rf /var/service/agetty-tty6
sudo ln -sf /etc/sv/dbus /var/service
sudo ln -sf /etc/sv/elogind /var/service
sudo ln -sf /etc/sv/NetworkManager /var/service
sudo sv stop dhcpcd
sudo sv start NetworkManager
echo

say "Installation finished. Consider rebooting the system for some service to start properly."
echo
