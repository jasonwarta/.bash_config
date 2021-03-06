#!/usr/bin/env bash

DIR="$(dirname "${BASH_SOURCE[0]}")"

# begin default aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# end default aliases


alias lh="ls -hal"

alias psl="ps -ef|grep -v 'grep --color=auto'|grep "

# disk usage aliased to show all files in human readable format
alias duh='du -ah'

alias sizeof="stat --format="%s""