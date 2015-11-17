# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
export HISTTIMEFORMAT="%d/%m/%y %T "

PATH=${PATH}:~/bin:~/dotfiles/bin

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
EDITOR=vim

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set xterm to 256color for applications that chek for that.
if [ "$COLORTERM" = "gnome-terminal" ] || [ "$COLORTERM" = "xfce4-terminal" ]
then
    export TERM=xterm-256color
elif [ "$COLORTERM" = "rxvt-xpm" ]
then
    export TERM=rxvt-256color
fi

#virtualenv stuff
export WORKON_HOME=$HOME/.virtualenvs 
[ -x /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# Set git autocompletion and PS1 integration
if [ -f /etc/bash_completion.d/git ]; then
    . /etc/bash_completion.d/git 
else 
    __git_ps1=""
fi
GIT_PS1_SHOWDIRTYSTATE=true

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Define some colors first:
red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
yellow='\[\e[1;33m\]'
purple='\[\e[1;35m\]'
PURPLE='\[\e[0;35m\]'
green='\[\e[1;32m\]'
GREEN='\[\e[0;32m\]'
NC='\[\e[0m\]'              # No Color

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes


if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    PS1="%{\033[35m%}<%{\033[1m%}%h%{\033[0;35m%}\|%{\033[1m%}%?%{\033[0;35m%}>%{\033[1;36m%}%n%{\033[0;36m%}@%{\033[1;32m%}%m%{\033[0;32m%}:%{\033[1;33m%}%~%{\033[33m%}%#%{\033[0m%} "
    GIT_PROMPT_START="${PURPLE}<${purple}\!${PURPLE}|${purple}\$?${PURPLE}>${NC}"
    GIT_PROMPT_END=" ${CYAN}\u${cyan}@${green}\h${GREEN}:${yellow}\w${NC}${yellow}>${NC} "
    PS1=${GIT_PROMPT_START}${GIT_PROMPT_END}
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

[ -a $HOME/.bash/gitprompt.sh ] && source $HOME/.bash/gitprompt.sh

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

case $(uname -s) in 
    Darwin|FreeBSD)
        export LS_OPTIONS='-G -F -b'
    ;;
    Linux)
        export LS_OPTIONS='--color=tty -F -b'
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #export LS_COLORS='no=00:fi=00:di=01;33:ln=01;36:pi=40;33:so=01;35:bd=44;32;01:cd=44;33;01:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=36:*.tgz=36:*.rpm=36:*.deb=36:*.arj=36:*.taz=36:*.lzh=36:*.zip=36:*.z=36:*.Z=36:*.gz=36:*.rar=36:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mp3=35:*.wav=35:*.au=35:*.mid=35:*.voc=35:*.mod=35:*.aiff=35:*.txt=01:*.html=01:*.htm=01:*.doc=01:*.ps=01:*.pdf=01:*.lyx=01:*.c=01;31:*.cc=01;31:*.icc=01;31:*.cpp=01;31:*.pas=01;31:*.asm=01;31:*.scm=01;31:*.pl=01;31:*.sh=01;31:*.csh=01;31:*.java=01;31:*.ml=01;31:*.pm=01;31:*.hh=07;31:*.h=07;31:*.o=32:*.a=32:*.so=32:*.obj=32:*.class=32:*Makefile=01;34:*README=01'
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# ssh hosts
HOSTFILE=~/.hosts

#function _ssh() {
#  local cur
#  cur=${COMP_WORDS[COMP_CWORD]}
#  if [ "${cur:0:1}" != "-" ]; then
#        COMPREPLY=( $(awk '/^Host '$2'/{print $2}' $HOME/.ssh/config) )
#  fi            
#  return 0
#}
#
#complete -F _ssh ssh sftp scp
#complete -A hostname ssh sftp scp

# The completion routines
_ssh_completion() 
{
        if [[ -r ~/.ssh && -r ~/.ssh/config ]]; then
                local cur prev opts
                COMPREPLY=()
                cur="${COMP_WORDS[COMP_CWORD]}"
                prev="${COMP_WORDS[COMP_CWORD-1]}"
                opts="-1 -2 -4 -6 -A -a -C -f -g -K -k -M -N -n -q -s -T -t -V -v -X -x -Y -y"
                optsargs="-b -c -D -e -F -I -i -L -l -m -o -O -p -R -S -w -W"

                if [[ ${cur} == -* ]]; then
                        # option completion
                        COMPREPLY=( $(compgen -W "${opts} ${optsargs}" -- ${cur}) )
                else
                        # current string is no option itself
                        if [[ ${prev} == -i ]] ; then
                                # if current option is -i, then complete identitys
                                priv_keys="`grep -l PRIVATE ~/.ssh/*`"  # find private key files 
                                COMPREPLY=( $(compgen -W "${priv_keys}" -- ${cur}) )
                        else
                                # if no option is given, then try to complete with hostname
                                hosts="`grep -i "^host " ~/.ssh/config |cut -d' ' -f2`"  # grep all lines
                                COMPREPLY=( $(compgen -W "${hosts}" -- ${cur}) )
                        fi
                fi
        fi
}

_scp_completion()
{
        if [[ -r ~/.ssh && -r ~/.ssh/config ]]; then
                local cur prev opts
                COMPREPLY=()
                cur="${COMP_WORDS[COMP_CWORD]}"
                prev="${COMP_WORDS[COMP_CWORD-1]}"
                opts="-1 -2 -4 -6 -B -C -p -q -r -v -i -h"

                if [[ ${cur} == -* ]]; then
                        # option completion
                        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
                else
                        # current string is no option itself
                        if [[ ${prev} == -i ]] ; then
                                # if current option is -i, then complete identitys
                                priv_keys="`grep -l PRIVATE ~/.ssh/*`"  # find private key files 
                                COMPREPLY=( $(compgen -W "${priv_keys}" -- ${cur}) )
                        else
                                # if no option is given, then try to complete with hostname and file names
                                hosts="`grep -i "^host " ~/.ssh/config |cut -d' ' -f2`"  # grep all lines
                                COMPREPLY=( $(compgen -f -W "${hosts}" -- ${cur}) )
                        fi
                fi
        fi
}


# Add completion functions to commands
complete -F _ssh_completion ssh
complete -F _scp_completion scp
complete -F _scp_completion sftp

function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}

# PAGER for man reading
#export PAGER="/bin/sh -c \"unset PAGER; col -b -x | vim -u /usr/share/vim/vimcurrent/macros/less.vim -c'set ft=man nomod nolist' \""
#export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
#              vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
#              -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
#              -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
export PAGER=~/dotfiles/bin/vimpager
alias less=$PAGER
alias zless=$PAGER

if [ -f "$HOME/.rvm/scripts/rvm" ]
then 
    source ~/.rvm/scripts/rvm
    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
    #rvm use 2.1.3
fi

if [ -f "$HOME/.bash_ec2.sh" ]; then
    source ~/.bash_ec2.sh
fi
export CONTENT_ACTIVATION_DEV_DB_HOST=int18

# aws credentials 
# [ -f /home/ido/.bash_aws ] && source /home/ido/.bash_aws

#logamazon:
export DEV_PEM=$HOME/.ssh/dev.pem
export AWS_CONFIG_FILE=$HOME/.aws-config

# added by travis gem
[ -f /home/ido/.travis/travis.sh ] && source /home/ido/.travis/travis.sh

if [ -f ~/.ssh/dev.pem ]; then ssh-add ~/.ssh/dev.pem &> /dev/null; fi
# AWS tunnel alias definitions.
if [ -f ~/.aws_tunnels.sh ]; then
    . ~/.aws_tunnels.sh
fi
