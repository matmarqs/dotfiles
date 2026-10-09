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

HISTSIZE=-1

## vi mode
#set -o vi
#bind -m vi-insert "\C-l":clear-screen
set -o emacs

# load aliases
source "$HOME/.config/shell/aliasrc"

## some functions to make life easier
# compiles a basic C program
c () {
   PROGDIR="$(dirname "$1")"
   gcc -g -Wall -O0 "$1" -lm -o "$PROGDIR"/a.out #&& "$PROGDIR"/a.out
}
crun () {
   PROGDIR="$(dirname "$1")"
   gcc -g -Wall -O0 "$1" -lm -o "$PROGDIR"/a.out && "$PROGDIR"/a.out
}
# compiles a C math program that uses the GSL library
cgsl () {
   PROGDIR="$(dirname "$1")"
	gcc -std=gnu99 -g -Wall -O2 "$1" -lgsl -lgslcblas -lm -o "$PROGDIR"/a.out
}
# compiles a basic C++ program
cpp () {
   PROGDIR="$(dirname "$1")"
   g++ -g -Wall -O2 "$1" -o "$PROGDIR"/a.out #&& "$PROGDIR"/a.out
}
# for music: check if mpd is running, if not it starts it. Then it opens ncmpcpp
music () {
    pgrep mpd &> /dev/null || mpd ; ncmpcpp -q
}
bind '"\em":"music\n"'

github () {
   git add . && git commit -m "$1" && git push
}

activate_venv() {
    venv_name=".venv"
    current_dir="$PWD"
    root_dir="/"

    # Check if a virtual environment is already activated
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "Virtual environment already active: $VIRTUAL_ENV" >&2
        return 0
    fi

    # Search upwards for .venv
    while [ "$current_dir" != "$root_dir" ]; do
        venv_path="$current_dir/$venv_name"

        if [ -d "$venv_path" ]; then
            if [ -f "$venv_path/bin/activate" ]; then
                echo "Found virtual environment at $venv_path"
                . "$venv_path/bin/activate"
                return 0
            else
                echo "Error: Found $venv_name but missing activate script" >&2
                return 1
            fi
        fi

        current_dir=$(dirname "$current_dir")
    done

    echo "Error: Could not find $venv_name in any parent directory" >&2
    return 1
}

alias pyv="activate_venv"

alias john="/home/sekai/tools/john/run/john"
export WINEPREFIX="/home/sekai/Desktop/winedev/wine/mydevprefix"
export PATH="/home/sekai/Desktop/winedev/wine/tools/wine:$PATH"

alias fd="fd --hidden"

stty -ixon
