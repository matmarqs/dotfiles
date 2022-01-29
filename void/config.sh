#!/bin/bash

## This script should only be executed on a FRESH Void Linux install.
## The script will copy all the config files to each path. This means that YOUR CONFIGS WILL BE OVERWRITTEN.

# This install script assumes the following:
# 1. You are on a FRESH Void Linux, have base-system installed and proper network connection.
# 2. The script was executed as a normal user (NOT root).
# 3. The script is inside its git directory, which has all the original files.
# 4. The following programs need to be configured manually:
#    fcitx-configtool, nvim (vim-plug, TSUpdate)

## FUNCTIONS

say () {
    printf "\n$1\n"
}

getAns () {
    # $1 = opt1, $2 = opt2, $3 = question, $4 = ans
    printf "\n$3 [$1/$2] "
    read _ans
    [ ! "$_ans" = "$1" ] && [ ! "$_ans" = "$2" ] && getAns "$1" "$2" "$3" "$4" || eval $4="'$_ans'" ; unset _ans
}

updateVoid () {
    echo "repository=https://mirrors.servercentral.com/voidlinux/current" | sudo tee /usr/share/xbps.d/00-repository-main.conf
    sudo xbps-install -Syu && sudo xbps-install -yu void-repo-nonfree   # 2 times in case xbps needs to be updated
    echo "repository=https://mirrors.servercentral.com/voidlinux/current/nonfree" | sudo tee /usr/share/xbps.d/10-repository-nonfree.conf
}

copying () {
    cp -r $DOTDIR/house/. $HOME
    sudo cp -r $DOTDIR/etc/. /etc
    sudo cp -r $DOTDIR/usr/. /usr
}

chmodExec () {
    sudo chmod -R +x /usr/local/scripts
    sudo chmod -R +x /usr/local/bin
    chmod -R +x "$HOME/.config/sxiv/exec"
    chmod +x "$HOME/.config/dynconf/aesthetics"
}

configDesktop () {
    # nothing yet
}

configVirtual () {
    sed -i '/xbacklight/s/^/\/\//g' $HOME/.local/dwm/config.def.h
    sed -i '/sb-bri/s/^/\/\//g' $HOME/.local/dwmblocks/blocks.def.h
    sed -i '/fcitx/s/^/#/' $HOME/.config/x11/xinitrc
}

configSudoers () {
    printf "\n## Giving permissions of some commands to the user\nCmnd_Alias SHUTDOWN_CMDS = /bin/poweroff, /bin/reboot, /bin/zzz\nCmnd_Alias NET_CMDS = /usr/local/bin/netrestart\n$THEUSER ALL = NOPASSWD: SHUTDOWN_CMDS, NET_CMDS\n" | sudo EDITOR='tee -a' visudo
}

configCron () {
    sudo ln -sf /etc/sv/cronie /var/service
    printf "# change light/dark theme\n15 18 * * * DISPLAY=:0 \$HOME/.config/dynconf/aesthetics\n15 07 * * * DISPLAY=:0 \$HOME/.config/dynconf/aesthetics\n# low battery notification\n*/10 * * * * DISPLAY=:0 /usr/local/scripts/lowbat\n" | sudo tee /var/spool/cron/$THEUSER
}

configThemes () {
    mkdir -p "$HOME/.config/gtk-2.0" "$HOME/.config/gtk-3.0"
    sudo tar -xzf $HOME/.local/appearance/BeautyLine/BeautyLine.tar.gz -C /usr/share/icons
    sudo tar -xzf $HOME/.local/appearance/Midnight/Midnight-BlueNight.tar.gz -C /usr/share/themes
    sudo tar -xzf $HOME/.local/appearance/Midnight/Midnight-GreenNight.tar.gz -C /usr/share/themes
    sudo tar -xf $HOME/.local/appearance/Sweet-Ambar-Blue/Sweet-Ambar-Blue.tar.xz -C /usr/share/themes
    sudo tar -xf $HOME/.local/appearance/Matcha-sea/Matcha-sea.tar.xz -C /usr/share/themes
    sudo unzip -qq $HOME/.local/appearance/mononoki/mononoki.zip -d /usr/share/fonts
    sudo mkdir -p /usr/share/icons/default
    printf "[icon theme]\nInherits=Breeze_Hacked\n" | sudo tee /usr/share/icons/default/index.theme
}

makeInstall () {
    cd $HOME/.local/dwm
    ln -sf config.def.h config.h
    sudo make -s clean install
    cd $HOME/.local/st
    ln -sf config.def.h config.h
    sudo make -s clean install
    cd $HOME/.local/dwmblocks
    ln -sf blocks.def.h blocks.h
    sudo make -s clean install
    cd $DOTDIR
}

createFolders () {
    mkdir -p $HOME/.cache $HOME/Music $HOME/Documents $HOME/Workspace $HOME/downloads
    mkdir -p $HOME/Pictures/prints $HOME/Pictures/wallpapers $HOME/Videos $HOME/.local/public
    mkdir -p $HOME/.local/share/mpd/playlists $HOME/.local/share/lyrics
}

deleteTrash () {
    [ -f $HOME/.inputrc ] && rm $HOME/.inputrc
    [ -f $HOME/.lesshst ] && rm $HOME/.lesshst
    [ -f $HOME/.bash_history ] && rm $HOME/.bash_history
}

serviceMan () {
    sudo rm -rf /var/service/sshd
    sudo rm -rf /var/service/acpid
    sudo rm -rf /var/service/agetty-tty4
    sudo rm -rf /var/service/agetty-tty5
    sudo rm -rf /var/service/agetty-tty6
    sudo ln -sf /etc/sv/dbus /var/service
    sudo ln -sf /etc/sv/elogind /var/service
}

configRoot () {
    sudo cp -r $DOTDIR/root/. $DOTDIR/house/.vim /root
    sudo mkdir -p /root/.config /root/.local/bin /root/.local/share /root/.cache
    sudo cp -r $DOTDIR/house/.config/shell $DOTDIR/house/.config/tmux $DOTDIR/house/.config/wget /root/.config
    sudo rm /root/.inputrc /root/.lesshst /root/.bash_history 2> /dev/null
    sudo chsh -s /bin/bash root
}

networkMan () {
    sudo rm -rf /var/service/dhcpcd
    sudo rm -rf /var/service/wpa_supplicant
    sudo ln -sf /etc/sv/NetworkManager /var/service
    say "You can connect to wifi via"
    echo "\$ nmcli device wifi connect BSSID password PASSWD ifname INTERFACE"
}

## THE ACTUAL THING

say "You can check the deps directory for dependencies."
getAns "y" "n" "Your config files will be overwritten. Continue?" "CONTINUE"
[ "$CONTINUE" != "y" ] && echo && exit
echo

getAns "d" "v" "Do you plan to use this system as desktop (d) or virtual machine (v)?" "USAGE"

# getting the variables
THEUSER=$(whoami)
DOTDIR=$(dirname "$(realpath $0)")
if [ "$USAGE" = "d" ]; then
    MYDEPS=$(cat $DOTDIR/deps/deps.txt $DOTDIR/desktop/deps/deps-desktop.txt)
else
    MYDEPS=$(cat $DOTDIR/deps/deps.txt $DOTDIR/virtual/deps/deps-virtual.txt)
fi

say "Changing to the best repository I know, upgrading and adding non-free repository."
updateVoid ; echo

say "Installing dependencies with xbps."
sudo xbps-install -Sy $MYDEPS ; echo

# manual dependencies check
getAns "y" "n" "The dependencies were installed successfully? Continue?" "DEPSOK"
[ "$DEPSOK" = "n" ] && say "Aborting installation." && exit

say "Copying all files to respective directories."
copying ; echo

# checking if DESKTOP or VIRTUAL and configuring
if [ "$USAGE" = "d" ]; then
    configDesktop
else
    configVirtual
fi

say "Making scripts executable."
chmodExec ; echo

say "Adding some lines to /etc/sudoers for some convenient commands."
configSudoers ; echo

say "Setting up crontab."
configCron ; echo

say "Extracting GTK, Qt themes and fonts."
configThemes ; echo

say "Compiling and installing programs."
makeInstall ; echo

say "Creating some folders."
createFolders ; echo

say "Fixing Void Linux fonts."
sudo ln -sf /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d && sudo xbps-reconfigure -f fontconfig ; echo

say "Deleting some trash."
deleteTrash ; echo

say "Configuring some files for root."
configRoot ; echo

say "Disabling and enabling some services."
serviceMan ; echo

getAns "y" "n" "Do you want to disable other network services and enable NetworkManager?" "NETWORKMAN"
if [ "$NETWORKMAN" = "y" ]; then
    networkMan ; echo
fi

say "Installation finished. Consider rebooting the system for services to start properly." ; echo
