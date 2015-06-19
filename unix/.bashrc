#!/bin/bash

if [ -f ~/.profile ]; then
  source .profile
else
  export MYLOC=UNKNOWN
fi

alias gstat="git status --short"
alias ls="ls --color"
alias la="ls -a --color"
alias ll="ls -al --color"
alias lt="ls -altr --color"
alias cup="cd ../"

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

add2path /home/grasingerm/Dev/mads/bin/Release
PYTHONPATH=$PYTHONPATH:.

# LANL specific vars and functions
if [ $MYLOC == "LANL" ]; then
  echo "This is LANL."
  lanlsrc="bash/.lanl_bashrc" 
  if [ -a $lanlsrc ]; then
    source $lanlsrc
  else
    echo "$lanlsrc not found!"
  fi
fi # LANL

# My personal configurations for Pitt and Home
if [ $MYLOC == "PC" ]; then
  echo "This is mine?"

  useclang
  add2cflags "-Wall -Wextra -g -pedantic -pedantic-errors -O3 -std=c99"
  add2cxxflags "-Wall -Wextra -g -pedantic -pedantic-erros -O3 -std=c++11"

  alias connectpittws="ssh matthewgrasinger@136.142.112.33"
  alias xconnectpittws="ssh -X matthewgrasinger@136.142.112.33"
  alias connectpittpc="ssh clementine@136.142.112.27"
  alias xconnectpittpc="ssh -X clementine@136.142.112.27"
fi # PC
