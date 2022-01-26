# bash setting for OS X

export RUSS_LS_OPTS='-FhG'
PS1='\[\e[0;33m\]\h:\W \u\$\[\e[m\] '

if [ "$RUSS_INTERACTIVE" = "TRUE" ]; then
  # Set up ctrl-arrow keys for searching - generates errors if non-interactive
  bind '"\e[5A": history-search-backward'
  bind '"\e[5B": history-search-forward'
  bind '"\e[5C": forward-word'
  bind '"\e[5D": backward-word'
fi

alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
alias airplayreset='sudo pkill coreaudiod'

# Add local directories to path, if available (PATH will be exported in top-level bashrc)
if [ -d /opt/subversion/bin ]; then
      PATH=/opt/subversion/bin:$PATH
fi
if [ -d /usr/local/git/bin ]; then
      PATH=/usr/local/git/bin:$PATH
fi
if [ -d ~/Library/Python/2.7/bin/ ]; then
      PATH=$PATH:~/Library/Python/2.7/bin/
fi

if [ -d "/Library/Frameworks/Python.framework/Versions/3.8/bin" ] ; then
    PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
        if [ -d "/Users/russ/Library/Python/3.8/bin" ] ; then
            PATH="/Users/russ/Library/Python/3.8/bin:${PATH}"
        fi
fi

if [ -d /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin ]; then
      PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
fi

# Other useful commands:
# >  caffeinate  [keep system from sleeping]
# >  sudo killall -HUP mDNSResponder  [flush DNS cache]
# >  lsof -i | grep ESTABLISHED|less   [list open network connections]
# >  networksetup -getdnsservers ethernet  [query network settings]
# >  open   [cause Finder to launch document/directory/program]
# >  opendiff   [graphical diff]
# >  qlmanage   [manage QuickLook settings or show preview of doc]

