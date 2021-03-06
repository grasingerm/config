filetype off " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'lervag/vimtex'
Plugin 'JuliaLang/julia-vim'
Plugin 'elzr/vim-json'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Mizuchi/STL-Syntax'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'crusoexia/vim-monokai'
Plugin 'flazz/vim-colorschemes'
Plugin 'dkprice/vim-easygrep'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'jpalardy/vim-slime'
Plugin 'zyedidia/literate.vim'
Plugin 'chrisbra/unicode.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'scrooloose/nerdcommenter'
Plugin 'gnuplot.vim'
Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
else
  "force terminal to use 256 colors
  set t_Co=256
endif
let g:monokai_thick_border = 1
colorscheme monokai

" General configuration
set cursorline
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
set so=7
" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" Turn on the WiLd menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
set wildignore+=.git\*,.hg\*,.svn\*
endif
"Always show current position
set ruler
set colorcolumn=80
set showmode
" Height of the command bar
set cmdheight=2
" A buffer becomes hidden when it is abandoned
set hid
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
set mouse=a
endif
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Add a bit extra margin to the left
set foldcolumn=1

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac
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

" word wrap
autocmd BufNewFile,BufRead *.tex setlocal wrap linebreak nolist textwidth=0 wrapmargin=0

" recognize gnuplot files
autocmd BufRead,BufNewFile *.plt set filetype=gnuplot
autocmd BufRead,BufNewFile *.gplt set filetype=gnuplot
autocmd BufRead,BufNewFile *.gnuplt set filetype=gnuplot

" C / C++ settings
set cindent
set cinoptions=g-1

" Better split navigation and opening
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" Map ;; to <Esc> to make exitting insert mode easier 
imap ;; <Esc>

" Map for split window resizing
map <C-up> :res +5 <Return>
map <C-down> :res -5 <Return>
map <C-right> :vertical resize +5 <Return>
map <C-left> :vertical resize -5 <Return>

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

let g:vimtex_toc_config = {
  \ 'name' : 'TOC',
  \ 'layers' : ['content', 'todo', 'include'],
  \ 'resize' : 1,
  \ 'split_width' : 50,
  \ 'todo_sorted' : 0,
  \ 'show_help' : 1,
  \ 'show_numbers' : 1,
  \ 'mode' : 2
  \}

let g:vimtex_view_general_viewer = 'okular'
