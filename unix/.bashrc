#!/bin/bash

if [ -f ~/.loc ]; then
  source ~/.loc
else
  echo ".loc not found!"
  export MYLOC=UNKNOWN
fi

alias gstat="git status --short"
alias ls="ls --color"
alias la="ls -a --color"
alias ll="ls -al --color"
alias lt="ls -altr --color"
alias lr="ls -alR --color"
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

function setflagsdefault () {
  add2cflags "$defaultflags -std=c99"
  add2cxxflags "$defaultflags -std=c++11"
}

function setflagsdebug () {
  add2cflags "$debugflags -std=c99"
  add2cxxflags "$debugflags -std=c++11"
}

function setflagsrelease () {
  add2cflags "$releaseflags -std=c99"
  add2cxxflags "$releaseflags -std=c++11"
}

usegcc
setflagsdefault

# Append `.` to PYTHONPATH
if [ "$PYTHONPATH" = "" ]; then
  export PYTHONPATH=.
else
  export PYTHONPATH=$PYTHONPATH:.
fi

# LANL specific vars and functions
if [ $MYLOC = "LANL" ] && [ $TERM = "xterm" ]; then
  echo "This is LANL."
  add2path /home/grasingerm/Dev/mads/bin/Release
  source ~/bash/.lanl_bashrc 
fi # LANL

# My personal configurations for Pitt and Home
if [ $MYLOC = "PC" ] && [ $TERM = "xterm" ] || [ $MYLOC = "MSYS" ] && [ $TERM = "xterm" ]; then
  echo "This is mine?"

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

  if [ $MYLOC = "MSYS" ]; then
    add2path "/c/Program Files (x86)/Vim/vim74"
    alias vim=gvim.exe
    export WINHOME="/c/Users/Matthew"
    function go2win() {
      cd $WINHOME/$1
    }
  fi
fi # PC
