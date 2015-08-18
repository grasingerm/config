#!/bin/bash

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
		;;
esac

use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	export PROMPT_COMMAND=__prompt_command  # Func to gen PS1 after CMDs

	function __prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[1;32m\]'
    local BGre='\[\e[0;32m\]'
    local BCyn='\[\e[0;36m\]'
    local Wht='\[\e[0;37m\]'
    local BWht='\[\e[1;37m\]'
    local BBlu='\[\e[1;34m\]'

    PS1+="\n${BGre}\u${BCyn}@\h"

    if [ $EXIT != 0 ]; then
      PS1+=" ${Red}:("      # Add red if exit code non 0
    else
      PS1+=" ${Gre}:)"
    fi

    PS1+=" ${BBlu}\w${BWht}\n\$${Wht} "
	}

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

if [ -f ~/.loc ]; then
  source ~/.loc
else
  echo ".loc not found!"
  export MYLOC=UNKNOWN
fi

# badass terminal colors
#PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

export EDITOR=vim

alias tmux="TERM=screen-256color-bce tmux"
alias gstat="git status --short"
alias ls='ls --color=auto'
#alias ls="ls --color"
alias la="ls -a --color=auto"
alias ll="ls -al --color=auto"
alias lt="ls -altr --color=auto"
alias lr="ls -alR --color=auto"
alias cup="cd ../"

function gitfetchall () {
  if [ $# -eq 0 ]; then
    dir=.
  else
    dir=$1
  fi

  for i in $dir/*; do
    if [ -d $i ]; then
      pushd $i
      git pull origin master
      popd
    fi
  done
}

# count files and directories in the current path
function lscount() {
  count=$[`ls -l "$@" | wc -l` - 1]
  echo $count
}

function add2path() {
  export PATH=$PATH:$1
}

function ppath() {
  echo $PATH
}

function clearcflags() {
  export CFLAGS=""
}

function clearcxxflags() {
  export CXXFLAGS=""
}

function add2cflags() {
  export CFLAGS="$CFLAGS $1"
}

function add2cxxflags() {
  export CXXFLAGS="$CXXFLAGS $1"
}

function usegcc() {
  export CC=gcc-4.8
  export CXX=g++-4.8
}

function useclang() {
  export CC=clang-3.6
  export CXX=clang-3.6++
}

defaultflags="-Wall -Wextra"
debugflags="$defaultflags -g -pedantic -pedantic-errors"
releaseflags="$defaultflags -O3"

function clearflags() {
  export CFLAGS=""
  export CXXFLAGS=""
}

function setflagsdefault () { 
  clearflags
  add2cflags "$defaultflags -std=c99"
  add2cxxflags "$defaultflags -std=c++11"
}

function setflagsdebug () {
  clearflags
  add2cflags "$debugflags -std=c99"
  add2cxxflags "$debugflags -std=c++11"
}

function setflagsrelease () {
  clearflags
  add2cflags "$releaseflags -std=c99"
  add2cxxflags "$releaseflags -std=c++11"
}

setflagsdefault

# Append `.` to PYTHONPATH
if [ "$PYTHONPATH" = "" ]; then
  export PYTHONPATH=.
else
  export PYTHONPATH=$PYTHONPATH:.
fi

# LANL specific vars and functions
if [ $MYLOC = "LANL" ] && [ $TERM = "xterm" ]; then
  add2path /home/grasingerm/Dev/mads/bin/Release
  source ~/bash/.lanl_bashrc 
fi # LANL

# My personal configurations for Pitt and Home
if [ $MYLOC = "PC" ] || [ $MYLOC = "MSYS" ]; then
  function apt-refresh() {
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get autoremove
  }

  wsip=136.142.112.33
  pcip=136.142.112.27

  alias connpittws="ssh matthewgrasinger@$wsip"
  alias xconnpittws="ssh -X matthewgrasinger@$wsip"
  alias connpittpc="ssh clementine@$pcip"
  alias xconnpittpc="ssh -X clementine@$pcip"

  function fetchpittws ()
  {
    if [ $# -eq 2 ]; then
      scp matthewgrasinger@$wsip:$1 $2
    else
      echo "usage: fetchpittws remote_path local_path"
    fi
  }

  function fetchpittpc ()
  {
    if [ $# -eq 2 ]; then
      scp clementine@$pcip:$1 $2
    else
      echo "usage: fetchpittws remote_path local_path"
    fi
  }

  export SPRNG_INC="/usr/local/sprng2.0/include"
  export SPRNG_LIB="/usr/local/sprng2.0/lib"

  if [ $MYLOC = "MSYS" ]; then
    add2path "/c/Program Files (x86)/Vim/vim74"
    alias vim=gvim.exe
    export WINHOME="/c/Users/Matthew"
    function go2win() {
      cd $WINHOME/$1
    }
  fi

  alias clang=clang-3.6
  alias clang++=clang++-3.6
fi # PC
