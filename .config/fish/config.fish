if status is-interactive
    # PATH
    fish_add_path $HOME/bin $HOME/dotfiles/bin

    # Environment
    set -gx GPG_TTY (tty)
    set -gx JAVA_HOME (/usr/libexec/java_home)

    # XDG base directories
    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx XDG_STATE_HOME $HOME/.local/state
    set -gx XDG_CACHE_HOME $HOME/.cache

    # Safe aliases
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'

    # eza aliases
    alias ls='eza -G --color auto --icons -a'
    alias ll='eza -l --color always --icons -a -snew'

    # Machine-specific overrides
    if test -f $HOME/.config/fish/config.local.fish
        source $HOME/.config/fish/config.local.fish
    end
end
