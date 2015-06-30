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

function add2cflags() {
  export CFLAGS="$CFLAGS $1"
}

function add2cxxflags() {
  export CXXFLAGS="$CXXFLAGS $1"
}

function usegcc() {
  export CC=gcc
  export CXX=g++
}

function useclang() {
  export CC=clang-3.6
  export CXX=clang-3.6++
}

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

# Append `.` to PYTHONPATH
if [ "$PYTHONPATH" = "" ]; then
  export PYTHONPATH=.
else
  export PYTHONPATH=$PYTHONPATH:.
fi

# LANL specific vars and functions
if [ $MYLOC = "LANL" ]; then
  echo "This is LANL."
  add2path /home/grasingerm/Dev/mads/bin/Release
  source ~/bash/.lanl_bashrc 
fi # LANL

# My personal configurations for Pitt and Home
if [ $MYLOC = "PC" ] || [ $MYLOC = "MSYS" ]; then
  echo "This is mine?"

  useclang
  add2cflags "-Wall -Wextra -g -pedantic -pedantic-errors -O3 -std=c99"
  add2cxxflags "-Wall -Wextra -g -pedantic -pedantic-erros -O3 -std=c++11"

  alias connectpittws="ssh matthewgrasinger@136.142.112.33"
  alias xconnectpittws="ssh -X matthewgrasinger@136.142.112.33"
  alias connectpittpc="ssh clementine@136.142.112.27"
  alias xconnectpittpc="ssh -X clementine@136.142.112.27"

  if [ $MYLOC = "MSYS" ]; then
    add2path "/c/Program Files (x86)/Vim/vim74"
    alias vim=gvim.exe
    export WINHOME="/c/Users/Matthew"
    function go2win() {
      cd $WINHOME/$1
    }
  fi
fi # PC
