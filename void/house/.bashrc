#
# ~/.bashrc
#

## colors for the prompt
#BLACK='\[\e[0;30m\]'
#BBLACK='\[\e[1;30m\]'
#BGBLACK='\[\e[40m\]'
#RED='\[\e[0;31m\]'
BRED='\[\e[1;31m\]'
#BGRED='\[\e[41m\]'
GREEN='\[\e[0;32m\]'
BGREEN='\[\e[1;32m\]'
#BGGREEN='\[\e[1;32m\]'
#YELLOW='\[\e[0;33m\]'
BYELLOW='\[\e[1;33m\]'
#BGYELLOW='\[\e[1;33m\]'
#BLUE='\[\e[0;34m\]'
BBLUE='\[\e[1;34m\]'
#BGBLUE='\[\e[1;34m\]'
#MAGENTA='\[\e[0;35m\]'
BMAGENTA='\[\e[1;35m\]'
#BGMAGENTA='\[\e[1;35m\]'
#CYAN='\[\e[0;36m\]'
#BCYAN='\[\e[1;36m\]'
#BGCYAN='\[\e[1;36m\]'
WHITE='\[\e[0;37m\]'
#BWHITE='\[\e[1;37m\]'
#BGWHITE='\[\e[1;37m\]'

# prompt (colors are defined in .bash_profile)
PS1="${BRED}[${BYELLOW}\u${BGREEN}@${BBLUE}\h ${BMAGENTA}\W${BRED}]${GREEN}\$ ${WHITE}"

# vi mode
set -o vi
bind -m vi-insert "\C-l":clear-screen

# load aliases
source "$HOME/.config/shell/aliasrc"

## some functions to make life easier
# compiles a basic C program and runs it
c () {
	gcc -O2 -lm $1 && ./a.out
}
# compiles a C math program that uses the GSL library
cgsl () {
	gcc -I/usr/include -g -Wall -O3 $1 -L/usr/lib -lpthread -lgsl -lgslcblas -lm
}
# compiles a C math program that uses the GSL, GMP, FLINT libraries
cm () {
	gcc -I/usr/include -g -Wall -O3 $1 -L/usr/lib -lflint -lmpfr -lgmp -lpthread -lgsl -lgslcblas -lm
}
# for music: check if mpd is running, if not it starts it. Then it opens ncmpcpp
music () {
    pgrep mpd &> /dev/null || mpd ; ncmpcpp -q
}
bind '"\em":"music\n"'
