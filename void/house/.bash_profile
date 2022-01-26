#
# ~/.bash_profile
#

# PATH variable
export PATH="$HOME/.local/bin:$PATH"

# default programs
export TERMINAL="st"
export TERMCMD="st"
export EDITOR="vim"
export BROWSER="firefox"

# $HOME clean-up
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # this line will break some DMs.
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/bash_history"

# program settings
export RANGER_LOAD_DEFAULT_RC="FALSE"   # ranger config file
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS="-R --use-color -Dd+G$-Du+r$-DS+kY$-DE+Y$-DP+Y"
export MANPAGER="less -R --use-color -Dd+G -Du+r -DS+kY -DE+Y -DP+Y"
export _JAVA_AWT_WM_NONREPARENTING=1    # fix for Java applications in dwm
export CM_SELECTIONS="clipboard"        # clipmenu: clipboard manager based on dmenu.
export CM_OUTPUT_CLIP=0     # docs: clipmenud -h, clipmenu -h, clipctl -h.
export CM_MAX_CLIPS=64

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
