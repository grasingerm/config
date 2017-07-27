#!/bin/bash

rm ~/.bashrc
ln -s `readlink -f ./unix/.bashrc` ~/.bashrc
ln -s `readlink -f ./unix/.tmux.conf` ~/.tmux.conf
ln -s `readlink -f ./vim/.vimrc` ~/.vimrc
ln -s `readlink -f ./git/.gitconfig` ~/.gitconfig
ln -s `readlink -f ./git/.gitmessage.txt` ~/.gitmessage.txt

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
