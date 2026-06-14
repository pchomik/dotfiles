function load_options() {
    # Load completions, but only run the expensive validation when the cache is stale.
    autoload -Uz compinit
    local zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ ! -f "$zcompdump" || -n "$zcompdump"(#qN.mh+24) ]]; then
        compinit
    else
        compinit -C
    fi

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
