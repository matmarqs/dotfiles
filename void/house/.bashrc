#
# ~/.bashrc
#

# prompt (colors are defined in .bash_profile)
PS1="${BRED}[${BYELLOW}\u${BGREEN}@${BBLUE}\h ${BMAGENTA}\W${BRED}]${GREEN}\$ ${WHITE}"

# vi mode
set -o vi
bind -m vi-insert "\C-l":clear-screen

# load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

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
