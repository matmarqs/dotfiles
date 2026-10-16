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
      printf "%s [%s/%s] " "$1" "$2" "$3" >&2
      read -r _ans

      if [ "$_ans" = "$2" ] || [ "$_ans" = "$3" ]; then
         break
      fi
      echo "Invalid input. Please choose a valid option: [$2/$3]." >&2
   done

   echo "$_ans"
   unset _ans
}

# Pass additional flags to the stowPackages function.
# They will be passed to stow itself.
# Example:
#   stowPackages --adopt
stowPackages () {
   stow -R -v -d user-stow -t ~ bash config local vim "$@"
   sudo stow -R -v -d system-stow -t /usr/local usr-local "$@"
   sudo stow -R -v -d system-stow -t /root root "$@"
   sudo stow -R -v -d system-stow -t /etc etc "$@"
}

# The main function will pass additional flags to the stowPackages function.
# Call it like this: main "$@"
main() {
   if isRoot; then
      echo "You are root. Run this installation script as normal user." >&2
      exit 1
   fi

   option=$(getAns "Execute stowPackages $@?" 'y' 'n')
   if [ "$option" = "y" ]; then
      stowPackages "$@"
   else
      exit 0
   fi
}

main "$@"
