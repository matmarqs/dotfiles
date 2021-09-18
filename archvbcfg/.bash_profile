#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Clipmenu: clipboard baseado no dmenu.
# "clipmenud -h", "clipmenu -h" ou "clipctl -h" para documentacao.
export CM_SELECTIONS="clipboard"
export CM_OUTPUT_CLIP=0
export CM_MAX_CLIPS=8
