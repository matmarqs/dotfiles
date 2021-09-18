#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Aplicacoes padrao
export EDITOR="vim"
export VISUAL="vim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"

# IBus, input method para escrever em japones.
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
#export XIM_PROGRAM=/usr/bin/ibus-daemon
