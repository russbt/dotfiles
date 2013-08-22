# bash setting for OS X

export RUSS_LS_OPTS='-FhG'
PS1='\[\e[0;33m\]\h:\W \u\$\[\e[m\] '

# Set up ctrl-arrow keys for searching
bind '"\e[5A": history-search-backward'
bind '"\e[5B": history-search-forward'
bind '"\e[5C": forward-word'
bind '"\e[5D": backward-word'

alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'

