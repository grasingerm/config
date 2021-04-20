# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	export PROMPT_COMMAND=__prompt_command  # Func to gen PS1 after CMDs

	function __prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[1;32m\]'
    local BGre='\[\e[0;32m\]'
    local BCyn='\[\e[0;36m\]'
    local Wht='\[\e[0m\]'
    local BWht='\[\e[1;37m\]'
    local BBlu='\[\e[1;34m\]'

    PS1+="\n${BGre}\u${BCyn}@\h"

    if [ $EXIT != 0 ]; then
      PS1+=" ${Red}:("      # Add red if exit code non 0
    else
      PS1+=" ${Gre}:)"
    fi

    PS1+=" ${BBlu}\w${BWht}\n\$${Wht} "
	}
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -x /usr/bin/mint-fortune ]; then
     /usr/bin/mint-fortune
fi

# ========== my aliases and env variables ============
alias tmux="TERM=screen-256color tmux"
alias julia="julia --color=yes"
alias julia-fast="julia --color=yes --math-mode=fast --optimize=3 --check-bounds=no --depwarn=no"
alias julia-quiet="julia --color=yes --depwarn=no"

export EDITOR=vim
export PATH=$PATH:/usr/local/visit/bin:/snap/bin

# count files and directories in the current path
function lscount() {
  count=$[`ls -l "$@" | wc -l` - 1]
  echo $count
}

function add2path() {
  export PATH=$PATH:$1
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
  export CPPFLAGS=$CXXFLAGS
}

defaultflags="-Wall -Wextra"
debugflags="$defaultflags -Wpedantic -g -pedantic -pedantic-errors"
releaseflags="$defaultflags -O3"

function clearflags() {
  export CFLAGS=""
  export CXXFLAGS=""
  export CPPFLAGS=$CXXFLAGS
}

function setflagsdefault () { 
  clearflags
  add2cflags "$defaultflags -std=c99"
  add2cxxflags "$defaultflags -std=c++14"
  export CPPFLAGS=$CXXFLAGS
}

function setflagsdebug () {
  clearflags
  add2cflags "$debugflags -std=c99"
  add2cxxflags "$debugflags -std=c++14"
  export CPPFLAGS=$CXXFLAGS
}

function setflagsrelease () {
  clearflags
  add2cflags "$releaseflags -std=c99"
  add2cxxflags "$releaseflags -std=c++14"
  export CPPFLAGS=$CXXFLAGS
}

function set-cc()
{
  if [ $# -eq 1 ]; then
    export CC=$1
    export OMPI_CC=$CC
  else
    echo "usage: set-cc [c compiler]"
  fi
}

function set-cxx()
{
  if [ $# -eq 1 ]; then
    export CXX=$1
    export OMPI_CXX=$CXX
  else
    echo "usage: set-cxx [cxx compiler]"
  fi
}

function cmfunc ()
{
  if [ $# -eq 3 ]; then
    mkdir build
    cd build
    cmake -DCMAKE_BUILD_TYPE=$1 -DCMAKE_C_COMPILER=$2 \
          -DCMAKE_CXX_COMPILER=$3 ..
    make
  elif [ $# -eq 1 ]; then
    if [ -z "$CC" ]; then
      CC=cc
    fi
    if [ -z "$CXX" ]; then
      CXX=c++
    fi
    mkdir build
    cd build
    cmake -DCMAKE_BUILD_TYPE=$1 -DCMAKE_C_COMPILER=$CC \
          -DCMAKE_CXX_COMPILER=$CXX ..
    make
  else
    echo "usage: cmfunc \$build_type [\$cc] [\$cxx]"
    echo "\$build_type = [None, Debug, Release, RelWithDebInfo, MinSizeRel]"
  fi
}

function cmdebug ()
{
  if [ $# -eq 2 ]; then
    cmfunc Debug $1 $2
  elif [ $# -eq 0 ]; then
    cmfunc Debug
  else
    echo "usage: cmdebug [\$cc] [\$cxx]"
  fi
}

function cmrel ()
{
  if [ $# -eq 2 ]; then
    cmfunc Release $1 $2
  elif [ $# -eq 0 ]; then
    cmfunc Release
  else
    echo "usage: cmrel [\$cc] [\$cxx]"
  fi
}

function compile-latex()
{
  if [ $# -eq 1 ]; then
    pdflatex -interaction=nonstopmode $1.tex
    bibtex -interaction=nonstopmode $1.aux
    pdflatex -interaction=nonstopmode $1.tex
    pdflatex -interaction=nonstopmode $1.tex
  else
    echo "usage: compile-latex [latex-file.tex]"
  fi
}

# Append `.` to PYTHONPATH
if [ "$PYTHONPATH" = "" ]; then
  export PYTHONPATH=.
else
  export PYTHONPATH=$PYTHONPATH:.
fi

alias dbg-julia="JULIA_DEBUG=all julia --color=yes"

alias conn_home="ssh clementine@174.97.126.70"

alias myPush="rclone copy ~/google-drive pdrive:"
alias myPull="rclone copy pdrive: ~/google-drive"
alias myPushPull="myPush && myPull"
alias mySyncPush="rclone sync ~/google-drive pdrive:"
alias mySyncPull="rclone sync pdrive: ~/google-drive"
