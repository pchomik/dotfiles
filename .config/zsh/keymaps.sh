function set_keymap() {
    bindkey '^p' history-search-backward
    bindkey '^n' history-search-forward

    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word

    bindkey '^[[H'  beginning-of-line      # Home (Windows Terminal)
    bindkey '^[[F'  end-of-line            # End (Windows Terminal)
    bindkey '^[[1~' beginning-of-line      # Home (Alternative)
    bindkey '^[[4~' end-of-line            # End (Alternative)
    bindkey '^[[7~' beginning-of-line      # Home (Alternative)
    bindkey '^[[8~' end-of-line            # End (Alternative)
    bindkey '^OH'   beginning-of-line      # Home (Application mode)
    bindkey '^OF'   end-of-line            # End (Application mode)

    bindkey '^[[3~' delete-char            # Delete
    bindkey '^[[3;5~' kill-word            # Ctrl+Delete (delete word)
    bindkey '^?'    backward-delete-char    # Backspace

    export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
    export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

}
