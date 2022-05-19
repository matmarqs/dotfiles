#
# ~/.bashrc
#

## colors for the prompt

## Regular text color
#BLACK='\[\e[0;30m\]'
## Bold text color
#BBLACK='\[\e[1;30m\]'
## background color
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
BCYAN='\[\e[1;36m\]'
#BGCYAN='\[\e[1;36m\]'
WHITE='\[\e[0;37m\]'
#BWHITE='\[\e[1;37m\]'
#BGWHITE='\[\e[1;37m\]'

# prompt
PS1="${BCYAN}[${BRED}\u${BGREEN}@${BBLUE}\h ${BMAGENTA}\W${BCYAN}]${GREEN}\$ ${WHITE}"

# color for commands
alias ls='ls --color=auto'
alias la="ls -A"
alias ll="ls -lA"
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# vi mode
set -o vi
bind -m vi-insert "\C-l":clear-screen

# aliases
alias py="python"
alias v="vim"
alias vi="vim"
alias nv="nvim"
alias rg="ranger"
alias tmux="tmux -2"
alias off="sudo poweroff"
alias rbt="sudo reboot"
alias m="make"
alias mc="make clean"
alias km="killall mpd"
alias nf="neofetch | lolcat"
alias net="sudo netrestart"
alias xbi="sudo xbps-install"
alias xbq="xbps-query"
alias xbr="sudo xbps-remove"
alias pg="ps aux | grep"
alias zzz="sudo zzz"
