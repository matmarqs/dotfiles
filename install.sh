#!/bin/sh

# No arguments.
# Example:
#   if isRoot; then
#      echo "You are root."
#   fi
#   isRoot
#   user_id=$?
#   if [ "$user_id" = 0 ]; then
#      echo "You are root."
#   fi
isRoot() {
   return "$(id -u)"
}

# Arguments: $1 = question, $2 = option_1, $3 = option_2
# Example:
#   answer=$(getAns 'Continue?' 'y' 'n')
#   if [ "$answer" = "n" ]; then
#      exit 0
#   fi
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
   cat "$INPUT_SUDOERS" | sed "s/sekai/$USER/g" | sudo tee -a /etc/sudoers
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

# The main function will pass additional flags to the stowPackages function.
# Call it like this: main "$@"
main() {
   if isRoot; then
      echo "$0: You are root. Run this installation script as normal user." >&2
      exit 1
   fi

   configCrontab

   return 0

   configSudoers

   option=$(getAns "Execute stowPackages $*?" 'y' 'n')
   if [ "$option" = "y" ]; then
      stowPackages "$@"
   else
      exit 0
   fi
}

main "$@"
