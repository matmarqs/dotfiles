#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '

# Vi mode
set -o vi
bind -m vi-insert "\C-l":clear-screen

# Aliases
alias py="python"
alias v="vim"
alias vi="vim"
alias nv="nvim"
alias rg="ranger"
alias tmux="tmux -2"
alias off="sudo poweroff"
alias m="make"
alias mc="make clean"

c () {
	gcc -O2 -lm $1 && ./a.out
}

cm () {
	gcc -I/usr/include -g -Wall -O3 $1 -L/usr/lib -lflint -lmpfr -lgmp -lpthread -lgsl -lgslcblas -lm && ./a.out
}
