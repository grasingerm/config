#!/bin/bash

ln -s `readlink -f ./unix/.bashrc` ~/.bashrc
ln -s `readlink -f ./unix/.tmux.conf` ~/.tmux.conf
ln -s `readlink -f ./vim/.vimrc` ~/.vimrc
ln -s `readlink -f ./git/.gitconfig` ~/.gitconfig
ln -s `readlink -f ./git/.gitmessage.txt` ~/.gitmessage.txt

if [ ! -f ~/.loc ]; then
  if [ "$#" -ne 1 ]; then
    MYLOC=UNKNOWN
    echo "setting 'MYLOC' to 'UNKNOWN', as it was not supplied"
  else
    MYLOC=$1
    echo "location is '$MYLOC'"
  fi

  echo "export MYLOC=$MYLOC" > ~/.loc
fi

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
