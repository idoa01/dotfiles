#!/bin/bash
# ~/.aliases  -- examples of fancy aliases
alias	loadaliases='source ~/.bash_aliases'
# Basic aliases
alias rm='rm -i'	# ask on remove
alias cp='cp -i'	# ask on overwrite
alias mv='mv -i'	# ask on overwrite
# add color support for ls
alias ls='ls $LS_OPTIONS'    # ls with color 
alias ll='ls $LS_OPTIONS -alhrt'         # list ls
alias llt='ll $LS_OPTIONS --sort time'    # list ls according to time
# less with ansi color
#alias less    'less -R'
alias lltr='ll -r --sort time' # list ls according to time, reversed
alias eclipse="UBUNTU_MENUPROXY=0 LIBOVERLAY_SCROLLBAR=0 eclipse"
#alias eclipse="UBUNTU_MENUPROXY=0 eclipse"
alias gd='git diff'
alias rvm="$HOME/.rvm/scripts/rvm"
alias selector="ssh -N -L 3307:localhost:3306 selector@DB-PLAYSLAVE-EAST"
alias mongo_selector="ssh -N -L 27071:localhost:27017 root@MONGO-PROD-A"
alias sshuttle="sshuttle -r shuttle-host 0/0"
alias vless='vim -u /usr/share/vim/vimcurrent/macros/less.vim'
