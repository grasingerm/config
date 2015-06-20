#!/bin/bash

ln ./unix/.bashrc ~/.bashrc
ln ./vim/.vimrc ~/.vimrc
ln ./git/.gitconfig ~/.gitconfig
ln ./git/.gitmessage.txt ~/.gitmessage.txt

if [ "$#" -ne 1 ]; then
  MYLOC=UNKNOWN
  echo "setting 'MYLOC' to 'UNKNOWN', as it was not supplied"
else
  MYLOC=$1
  echo "location is '$MYLOC'"
fi

if [ ! -f ~/.profile ]; then touch ~/.profile; fi
echo "export MYLOC=$MYLOC" >> ~/.profile

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
