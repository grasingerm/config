syntax enable
set hidden
set history=500
set number

set encoding=utf-8
set backspace=indent,eol,start
set autoread
set mouse=a

set noswapfile
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

if has('gui_running')
	set undodir=~/.vim/backups
	set undofile
endif

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set nowrap

set scrolloff=10
set sidescrolloff=15
set sidescroll=1
