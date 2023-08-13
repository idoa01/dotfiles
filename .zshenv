export PATH=$HOME/bin:$HOME/dotfiles/bin:"$PATH"
export GPG_TTY=$(tty)
export JAVA_HOME=$(/usr/libexec/java_home)

[ -f $HOME/.zshenv.local ] && source $HOME/.zshenv.local
