function set_keymap() {
    bindkey '^p' history-search-backward
    bindkey '^n' history-search-forward

    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word

    export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
    export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
}
