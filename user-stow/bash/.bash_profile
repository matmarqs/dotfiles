#
# ~/.bash_profile
#

# load bashrc
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# basic clean-up and settings
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export HISTFILE="$HOME/.bash_history"
export FZF_DEFAULT_OPTS="--layout=reverse"
export LESS="-R --use-color -Dd+G\$-Du+r\$-DS+kY\$-DE+Y\$-DP+Y"
export MANPAGER="less -R --use-color -Dd+G -Du+r -DS+kY -DE+Y -DP+Y"
# complete clean-up and settings
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # this line breaks a lot of applications that assume ~/.Xauthority
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export RANGER_LOAD_DEFAULT_RC="FALSE"   # ranger config file
export _JAVA_AWT_WM_NONREPARENTING=1    # fix for Java applications in dwm
export CM_SELECTIONS="clipboard"        # clipmenu: clipboard manager based on dmenu.
export CM_OUTPUT_CLIP=0                 # docs: clipmenud -h, clipmenu -h, clipctl -h.
export CM_MAX_CLIPS=0                   # 0 for infinity

# default programs
export TERMINAL="st"
export TERMCMD="st"
export EDITOR="vim"
export BROWSER="firefox"

# startx our xinitrc
alias startx='startx "$XINITRC"'

[ -f ~/.rbenv/bin/rbenv] && eval "$(~/.rbenv/bin/rbenv init - bash)"
[ -d "$HOME/.pyenv/bin" ] && export PYENV_ROOT="$HOME/.pyenv" && export PATH="$PYENV_ROOT/bin:$PATH"
which pyenv >/dev/null && eval "$(pyenv init - bash)"

[ -d "$HOME/.local/bin"] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.config/emacs/bin"] && export PATH="$HOME/.config/emacs/bin:$PATH"
[ -d "$HOME/tools/cross/bin"] && export PATH="$HOME/tools/cross/bin:$PATH"
[ -d "$HOME/.opencode/bin"] && export PATH="$HOME/.opencode/bin:$PATH"

[ -d "$HOME/.local/share/cargo/bin"] && export PATH="$HOME/.local/share/cargo/bin:$PATH"
[ -f "$HOME/.local/share/cargo/env"] && . "$HOME/.local/share/cargo/env"
