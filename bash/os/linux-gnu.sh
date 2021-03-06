# bash setting for linux

if [ "$RUSS_INTERACTIVE" = "TRUE" ]; then
  # Set up ctrl-arrow keys for searching - generates errors if non-interactive
  bind '"\e[1;5A": history-search-backward'
  bind '"\e[1;5B": history-search-forward'
  bind '"\e[1;5C": forward-word'
  bind '"\e[1;5D": backward-word'
  bind '"\e[5A": history-search-backward'
  bind '"\e[5B": history-search-forward'
  bind '"\e[5C": forward-word'
  bind '"\e[5D": backward-word'
fi

export RUSS_LS_OPTS='-Fh --color=auto'

