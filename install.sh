#!/bin/sh

getAns () {
   # we redirect the messages to stderr with >&2
   while true; do
      printf "%s: %s [%s/%s] " "$0" "$1" "$2" "$3" >&2
      read -r _ans

      if [ "$_ans" = "$2" ] || [ "$_ans" = "$3" ]; then
         break
      fi
      echo "$0: Invalid input. Please choose a valid option: [$2/$3]." >&2
   done

   echo "$_ans"
   unset _ans
}

# Pass additional flags to the stowPackages function.
# They will be passed to stow itself.
# Example:
#   stowPackages --adopt
stowPackages () {
   stow -R -d user-stow -t ~ bash config local vim "$@"
   sudo stow -R -d system-stow -t /usr/local usr-local "$@"
   sudo stow -R -d system-stow -t /root root "$@"
   sudo stow -R -d system-stow -t /etc etc "$@"
   echo "$0: packages stowed successfully!"
}

configSudoers() {
   INPUT_SUDOERS="others/sudoers"
   if sudo grep 'SHUTDOWN_CMDS' /etc/sudoers >/dev/null; then
      echo "$0: Sudoers already configured. Nothing was done."
      return 1
   fi
   # Sanity check that input sudoers file exists
   if [ ! -f "$INPUT_SUDOERS" ]; then
      echo "$0: Input file $INPUT_SUDOERS does not exist. Aborting!"
      return 1
   fi
   echo "$0: Appending the following to /etc/sudoers:"
   sed "s/sekai/$USER/g" "$INPUT_SUDOERS" | sudo EDITOR='tee -a' visudo
   echo
   echo "$0: /etc/sudoers was configured successfully!"
}

configCrontab() {
   INPUT_CRONTAB="others/crontab"
   # Sanity check that input crontab file exists
   if [ ! -f "$INPUT_CRONTAB" ]; then
      echo "$0: Input file $INPUT_CRONTAB does not exist. Aborting!"
      return 1
   fi
   if ! crontab -T "$INPUT_CRONTAB"; then
      echo "$0: There are issues with the input $INPUT_CRONTAB. Aborting!"
      return 1
   fi
   crontab "$INPUT_CRONTAB"
   echo "$0: Crontab installed successfully!"
}

configureVoidServices() {
   echo "$0: Disabling sshd."
   sudo rm -f /var/service/sshd  # sshd enabled or not?

   echo "$0: Disabling dhcpcd/wpa_supplicant and enabling NetworkManager."
   sudo rm -f /var/service/dhcpcd
   sudo rm -f /var/service/wpa_supplicant
   sudo ln -sf /etc/sv/NetworkManager /var/service
   echo "$0: You can connect to Wi-Fi with the command"
   echo "\t\$ nmcli device wifi connect BSSID ifname INTERFACE --ask"

   echo "$0: Enabling cronie, dbus, elogind, and keyd."
   sudo ln -sf /etc/sv/cronie /var/service
   sudo ln -sf /etc/sv/dbus /var/service
   sudo ln -sf /etc/sv/elogind /var/service
   sudo ln -sf /etc/sv/keyd /var/service

   echo "$0: Setting default shell to bash"
   sudo chsh -s /bin/bash "$USER"
   sudo chsh -s /bin/bash root
}

fixVoidFonts() {
   # https://docs.voidlinux.org/config/graphical-session/fonts.html#enabling-bitmap-fonts
   sudo ln -sf /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
   sudo xbps-reconfigure -f fontconfig
}

# TODO: This needs to be reviewed.
configThemes () {
   mkdir -p "$HOME/.config/gtk-2.0" "$HOME/.config/gtk-3.0"
   sudo tar -xzf "$HOME"/.config/appearance/BeautyLine/BeautyLine.tar.gz -C /usr/share/icons
   sudo tar -xzf "$HOME"/.config/appearance/Midnight/Midnight-BlueNight.tar.gz -C /usr/share/themes
   sudo tar -xzf "$HOME"/.config/appearance/Midnight/Midnight-GreenNight.tar.gz -C /usr/share/themes
   sudo tar -xf "$HOME"/.config/appearance/Sweet-Ambar-Blue/Sweet-Ambar-Blue.tar.xz -C /usr/share/themes
   sudo tar -xf "$HOME"/.config/appearance/Sweet-Dark/Sweet-Dark.tar.xz -C /usr/share/themes
   sudo tar -xf "$HOME"/.config/appearance/Matcha-sea/Matcha-sea.tar.xz -C /usr/share/themes
   sudo unzip -qq "$HOME"/.config/appearance/mononoki/mononoki.zip -d /usr/share/fonts
   sudo mkdir -p /usr/share/icons/default
   printf "[icon theme]\nInherits=Breeze_Hacked\n" | sudo tee /usr/share/icons/default/index.theme
}

# The main function will pass additional flags to the stowPackages function.
# Call it like this: main "$@"
main() {
   if [ "$(id -u)" -eq 0 ]; then
      echo "$0: You are root. Run this installation script as normal user." >&2
      exit 1
   fi

   #FIRST_INSTALL=$(getAns 'Installing the system for the first time?' 'y' 'n')
   FIRST_INSTALL="n"

   if [ "$FIRST_INSTALL" = "y" ]; then
      # Synchronize Void repositories
      sudo xbps-install -Sy
      # Make sure xbps is updated first
      sudo xbps-install -yu xbps
      # Updating Void Linux packages
      sudo xbps-install -yu

      # Install the important packages first
      sudo xbps-install -y dbus elogind keyd git base-devel unzip tar fontconfig

      # Suckless dwm/st build dependencies
      sudo xbps-install -y libX11-devel libXinerama-devel libxcb-devel libXft-devel freetype-devel fontconfig-devel libXrender-devel

      # TODO: git submodules of dwm, st, and dwmblocks

      configureVoidServices
      fixVoidFonts
   fi

   #CONF_CRONTAB=$(getAns "Configure crontab?" 'y' 'n')
   CONF_CRONTAB="n"
   if [ "$CONF_CRONTAB" = "y" ]; then
      configCrontab
   fi

   #CONF_SUDOERS=$(getAns "Config sudoers?" 'y' 'n')
   CONF_SUDOERS="n"
   if [ "$CONF_SUDOERS" = "y" ]; then
      configSudoers
   fi

   EXEC_STOW=$(getAns "Execute stowPackages $*?" 'y' 'n')
   if [ "$EXEC_STOW" = "y" ]; then
      stowPackages "$@"
   else
      exit 0
   fi
}

main "$@"
