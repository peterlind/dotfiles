#!/bin/bash
# increase the default 256 (did this for riak)
ulimit -n 4096

export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=/usr/local/bin/vim
export LESS='-FXR'

export HISTSIZE=10000
export HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT='%F %T '

# Fix for SIMBL colors (http://blog.infinitered.com/entries/show/6)
export CLICOLOR=1;

export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[0;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'
alias colorslist="set | egrep 'COLOR_\\w*'"  # lists all the color

#export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

# avoid encoding issues
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# prompt
#export PS1="\[${COLOR_LIGHT_PURPLE}\]\w $ \[${COLOR_NC}\]"

# git prompt
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWDIRTYSTATE=1
#export PS1="\[${COLOR_LIGHT_PURPLE}\]\w\[${COLOR_NC}\]$(__git_ps1 "(%s)")\[${COLOR_LIGHT_PURPLE}\] \$\[${COLOR_NC}\] "
#export PS1='\w$(__git_ps1 "(%s)") \$ '
#export PS1='\e[1;34m\w\e[0m $(__git_ps1 "(%s)") \e[1;35m\$ \e[0m'
export PS1='\D{%T} \[\e[1;34m\]\w\[\e[0m\] $(__git_ps1 "(%s)") \[\e[1;35m\]\$ \[\e[0m\]'

# rspec 2.x
export SPEC_OPTS="--color --format progress"

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

#rails 2/3
function ss {
  if [ -e "./script/server" ]; then
    bundle exec ./script/server $*
    return
  fi

  #foreman/shoreman
  if [ -e "./Procfile" ]; then
    shoreman $*
    return
  fi

  # binstubs
  if [ -e "./bin/rails" ]; then
    ./bin/rails server $*
    return
  fi

  if [ -e "./script/rails" ]; then
    ./script/rails server $*
    return
  fi
}

function sc {
  if [ -e "./script/console" ]; then
    bundle exec ./script/console $*
    return
  fi

  # binstubs
  if [ -e "./bin/rails" ]; then
    ./bin/rails console $*
    return
  fi

  if [ -e "./script/rails" ]; then
    ./script/rails console $*
    return
  fi
}

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [[ "Darwin" == `uname -s` ]]; then
   #remove LSCOLORS and GREP_COLOR so solarized and iterm are readable
   unset LSCOLORS
   unset GREP_COLOR

   #check homebrew coreutils are installed
   if [[ -f /usr/local/bin/gls ]]; then
       eval "`gdircolors -b ~/.DIR_COLORS`"
       alias ls="gls --color=auto"
   fi
fi

if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

# make them rubies faster
export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000

shopt -s histappend
