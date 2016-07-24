#!/bin/bash

export GOPATH=~/go
export PATH=$PATH:~/go/bin

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
alias more=less

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
    local Wht='\[\e[0m\]'
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

export EDITOR=vim

alias tmux="TERM=screen-256color-bce tmux"
alias julia="julia --color=yes"

# count files and directories in the current path
function lscount() {
  count=$[`ls -l "$@" | wc -l` - 1]
  echo $count
}

function add2path() {
  export PATH=$PATH:$1
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

defaultflags="-Wall -Wextra"
debugflags="$defaultflags -Wpedantic -g -pedantic -pedantic-errors"
releaseflags="$defaultflags -O3"

function clearflags() {
  export CFLAGS=""
  export CXXFLAGS=""
}

function setflagsdefault () { 
  clearflags
  add2cflags "$defaultflags -std=c99"
  add2cxxflags "$defaultflags -std=c++14"
}

function setflagsdebug () {
  clearflags
  add2cflags "$debugflags -std=c99"
  add2cxxflags "$debugflags -std=c++14"
}

function setflagsrelease () {
  clearflags
  add2cflags "$releaseflags -std=c99"
  add2cxxflags "$releaseflags -std=c++14"
}

setflagsdebug

function cmfunc ()
{
  if [ $# -eq 3 ]; then
    mkdir build
    cd build
    cmake -DCMAKE_BUILD_TYPE=$1 -DCMAKE_C_COMPILER=$2 \
          -DCMAKE_CXX_COMPILER=$3 ..
    make
  elif [ $# -eq 1 ]; then
    if [ -z "$CC" ]; then
      CC=cc
    fi
    if [ -z "$CXX" ]; then
      CXX=c++
    fi
    mkdir build
    cd build
    cmake -DCMAKE_BUILD_TYPE=$1 -DCMAKE_C_COMPILER=$CC \
          -DCMAKE_CXX_COMPILER=$CXX ..
    make
  else
    echo "usage: cmfunc \$build_type [\$cc] [\$cxx]"
    echo "\$build_type = [None, Debug, Release, RelWithDebInfo, MinSizeRel]"
  fi
}

function cmdebug ()
{
  if [ $# -eq 2 ]; then
    cmfunc Debug $1 $2
  elif [ $# -eq 0 ]; then
    cmfunc Debug
  else
    echo "usage: cmdebug [\$cc] [\$cxx]"
  fi
}

function cmrel ()
{
  if [ $# -eq 2 ]; then
    cmfunc Release $1 $2
  elif [ $# -eq 0 ]; then
    cmfunc Release
  else
    echo "usage: cmrel [\$cc] [\$cxx]"
  fi
}

function ffwrap()
{
  if [ $# -eq 3 ]; then
    ffmpeg -framerate $1 -pattern_type glob -i $2 $3
  else
    echo "usage: ffwrap [framerate] [pattern] [outfile]"
  fi
}

function compile-latex()
{
  if [ $# -eq 1 ]; then
    pdflatex $1.tex
    bibtex $1.aux
    pdflatex $1.tex
    pdflatex $1.tex
  else
    echo "usage: compile-latex [latex-file.tex]"
  fi
}

# Append `.` to PYTHONPATH
if [ "$PYTHONPATH" = "" ]; then
  export PYTHONPATH=.
else
  export PYTHONPATH=$PYTHONPATH:.
fi

# My personal configurations for Pitt and Home
if [ $MYLOC = "PC" ] || [ $MYLOC = "MSYS" ]; then
  wsip=136.142.112.33
  pcip=136.142.112.27
  ship=136.142.112.254
  myip=136.142.112.32
  ws2ip=136.142.112.25

  alias connpittws="ssh matthewgrasinger@$wsip"
  alias xconnpittws="ssh -X matthewgrasinger@$wsip"
  alias connpittpc="ssh matt@$pcip"
  alias xconnpittpc="ssh -X matt@$pcip"
  alias connpittsh="ssh matt@$ship"
  alias xconnpittsh="ssh -X matt@$ship"
  alias connpittmy="ssh matt@$myip"
  alias xconnpittmy="ssh -X matt@$myip"
  alias connpittws2="ssh matt@$ws2ip"
  alias xconnpittws2="ssh -X matt@$ws2ip"

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
fi # PC
