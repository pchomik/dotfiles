function load_options() {
    # Load completions
    autoload -Uz compinit && compinit

    # History
    HISTFILE=~/.zsh_history
    HISTSIZE=10000
    SAVEHIST=$HISTSIZE
    HISTDUP=erase
    setopt appendhistory
    setopt sharehistory
    setopt hist_ignore_space
    setopt hist_ignore_all_dups
    setopt hist_save_no_dups
    setopt hist_ignore_dups
    setopt hist_find_no_dups

    export BAT_THEME="Monokai Extended Origin"
}

