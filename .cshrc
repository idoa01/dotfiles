#!/bin/csh -f

#
# Personal C shell customizations
# Read at start of execution of each C shell
#

# No core dumps
limit coredumpsize 0

# Using lesspipe
eval `lesspipe`

# Environment variables
setenv	PAGER		less		# use 'less' rather then 'more'
setenv	EDITOR		vim 
setenv  PATH            ${PATH}:${HOME}/bin
# If non-interactive, exit
if (! $?prompt) exit 0

# color prompt and color ls (bad only if the shell is interactive):
if ( $?prompt ) then
	if ( $?tcsh ) then
		if ($TERM == "xterm" || $TERM == "linux" || $TERM == 'screen') then
			set prompt="%{\033[35m%}<%{\033[1m%}%h%{\033[0;35m%}\|%{\033[1m%}%?%{\033[0;35m%}>%{\033[1;36m%}%n%{\033[0;36m%}@%{\033[1;32m%}%m%{\033[0;32m%}:%{\033[1;33m%}%~%{\033[33m%}%#%{\033[0m%} "
			setenv LS_COLORS 'no=00:fi=00:di=01;33:ln=01;36:pi=40;33:so=01;35:bd=44;32;01:cd=44;33;01:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=36:*.tgz=36:*.rpm=36:*.deb=36:*.arj=36:*.taz=36:*.lzh=36:*.zip=36:*.z=36:*.Z=36:*.gz=36:*.rar=36:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mp3=35:*.wav=35:*.au=35:*.mid=35:*.voc=35:*.mod=35:*.aiff=35:*.txt=01:*.html=01:*.htm=01:*.doc=01:*.ps=01:*.pdf=01:*.lyx=01:*.c=01;31:*.cc=01;31:*.icc=01;31:*.cpp=01;31:*.pas=01;31:*.asm=01;31:*.scm=01;31:*.pl=01;31:*.sh=01;31:*.csh=01;31:*.java=01;31:*.ml=01;31:*.pm=01;31:*.hh=07;31:*.h=07;31:*.o=32:*.a=32:*.so=32:*.obj=32:*.class=32:*Makefile=01;34:*README=01'
			setenv LS_OPTIONS '--color=tty -F -b'		
#                else if ($TERM == "screen") then 
#			set prompt="%{\033[1;31m%}[S$WINDOW]%{\033[22;35m%}<%{\033[1m%}%h%{\033[0;35m%}\|%{\033[1m%}%?%{\033[0;35m%}>%{\033[1;36m%}%n%{\033[0;36m%}@%{\033[1;32m%}%m%{\033[0;32m%}:%{\033[1;33m%}%~%{\033[33m%}%#%{\033[0m%} "
#			setenv LS_COLORS 'no=00:fi=00:di=01;33:ln=01;36:pi=40;33:so=01;35:bd=44;32;01:cd=44;33;01:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=36:*.tgz=36:*.rpm=36:*.deb=36:*.arj=36:*.taz=36:*.lzh=36:*.zip=36:*.z=36:*.Z=36:*.gz=36:*.rar=36:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mp3=35:*.wav=35:*.au=35:*.mid=35:*.voc=35:*.mod=35:*.aiff=35:*.txt=01:*.html=01:*.htm=01:*.doc=01:*.ps=01:*.pdf=01:*.lyx=01:*.c=01;31:*.cc=01;31:*.icc=01;31:*.cpp=01;31:*.pas=01;31:*.asm=01;31:*.scm=01;31:*.pl=01;31:*.sh=01;31:*.csh=01;31:*.java=01;31:*.ml=01;31:*.pm=01;31:*.hh=07;31:*.h=07;31:*.o=32:*.a=32:*.so=32:*.obj=32:*.class=32:*Makefile=01;34:*README=01'
#			setenv LS_OPTIONS '--color=tty -F -b'		
		else	#xterm-linux    # colorful ANSI might disturb other terminals
			set prompt="%n@%m:%~%# "
			setenv LS_OPTIONS '-F'
		endif	#xterm-linux
	else		#tcsh
		set prompt = "`whoami`@$HOST> "
		setenv LS_OPTIONS '-F'
	endif		#tcsh

endif #prompt

# If interactive, switch over to Enhanced C shell

if (! $?tcsh) then
	foreach dir ($path)
		if ($dir =~ .*) continue
		if (-x $dir/tcsh) then
			set tcshpath = $dir/tcsh
			break
		endif
	end
	if ($?tcshpath) then
		setenv SHELL $tcshpath
		exec tcsh $argv
	endif
endif

# -------------------------------------------------
# Interactive C shell customizations

# Fancy aliases
if (-e ~/.aliases) source ~/.aliases

# Shell variables
#set savehist=200	# on logout, save last 200 commands in ~/.history 
set history=500		# remember last 500 commands
set inputmode=insert	# or '=overwrite'
set nobeep              # no beeps
set notify		# notify at once when a background job terminates
set noclobber		# to overwrite a file, must use '>!', not '>'
set ignoreeof		# to logout, must use 'exit', not Ctl-D
set correct=cmd		# or '=all'. Try to correct typing errors
set autoexpand
set autolist		# so <tab> lists possible completions (like Ctl-D)
set listmax=500		# so autolistings don't clutter screen
set pushdtohome		# pushd without arguments does 'pushd ~'
unset autologout        # disable the autologout feature

# Show a fortune cookie
if ( -x /usr/games/fortune ) then
   /usr/games/fortune
endif

# set xhost for current ip
if ( $?DISPLAY ) then
    setenv DISPLAYIP `echo $DISPLAY | awk -F: '{print $1}'`
    if ( $?DISPLAYIP ) then
        xhost +$DISPLAYIP > /dev/null
    endif
endif
