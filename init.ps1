cmd.exe /c mklink /H C:\Users\Matthew\.vimrc .\vim\.vimrc
cmd.exe /c mklink /H C:\Users\Matthew\.gitconfig .\git\.gitconfig
cmd.exe /c mklink /H C:\Users\Matthew\.gitmessage.txt .\git\.gitmessage.txt

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
