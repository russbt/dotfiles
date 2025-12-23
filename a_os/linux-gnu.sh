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

# Set a nice prompt

# Useful references:
#  https://www.maketecheasier.com/8-useful-and-interesting-bash-prompts/

# Useful bash prompt macros
#   \!: history number
#   \h: short hostname
#   \W: basename of working directory
#   \u: username
#   \[ and \] enclose any non-printing output (color change, for example)
#   \e: escape character (used for ANSI colors)
#   \e[0m: Reset to default colors
#   \e: Escape character, for colors (same as \033)
# Color palette:
#   Black       0;30     Dark Gray     1;30
#   Blue        0;34     Light Blue    1;34
#   Green       0;32     Light Green   1;32
#   Cyan        0;36     Light Cyan    1;36
#   Red         0;31     Light Red     1;31
#   Purple      0;35     Light Purple  1;35
#   Brown       0;33     Yellow        1;33
#   Light Gray  0;37     White         1;37
GREEN='\e[32m'
DKGREY='\e[1;30m'
LTGREY='\e[37m'
RED='\e[31m'
LTGRN='\e[1;32m'
LTBLUE='\e[1;34m'
RSTCLR='\e[0m'

# modify the \w and \W outputs to limit depth printed
PROMPT_DIRTRIM=2

# set prompt: displays red/green based on last command output,
#   history count and nested shell depth; user @ host;
#   working directory
PS1="\[${LTGREY}\][\! +${SHLVL}]\[${RSTCLR}\] \[\`if [ \$? = 0 ]; then echo ${GREEN}; else echo ${RED}; fi\`\]\u@\h\[${RSTCLR}\]: \[${LTBLUE}\]\w\[${RSTCLR}\]"'\$ '
