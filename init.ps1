cmd.exe /c mklink /H .\vim\.vimrc ~\.vimrc
cmd.exe /c mklink /H .\git\.gitconfig ~\.gitconfig
cmd.exe /c mklink /H .\git\.gitmessage.txt ~\.gitmessage.txt

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
