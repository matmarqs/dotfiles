#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Minhas variaveis
export TERMINAL="st"
export TERMCMD="st"
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="firefox"
export READER="zathura"

# Configuracao do ranger
export RANGER_LOAD_DEFAULT_RC="FALSE"

# Variaveis do clipmenu: clipboard baseado no dmenu.
# Para documentacao: clipmenud -h, clipmenu -h, clipctl -h.
export CM_SELECTIONS="clipboard"
export CM_OUTPUT_CLIP=0
export CM_MAX_CLIPS=64

# Tema GTK funcionar em Qt
export GTK2_RC_FILES=/etc/gtk-2.0/gtkrc
