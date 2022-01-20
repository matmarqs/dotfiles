#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# PATH variable
export PATH="$HOME/.local/bin:$PATH"

# my variables
export TERMINAL="st"
export TERMCMD="st"
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="firefox"
export READER="zathura"

# ranger config file
export RANGER_LOAD_DEFAULT_RC="FALSE"

# clipmenu: clipboard manager based on dmenu.
# for documentation: clipmenud -h, clipmenu -h, clipctl -h.
export CM_SELECTIONS="clipboard"
export CM_OUTPUT_CLIP=0
export CM_MAX_CLIPS=64

# gtk-2.0 config file path
export GTK2_RC_FILES=$HOME/.config/gtk-2.0/gtkrc
