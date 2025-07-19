function load_zstyle() {
    # Completion
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*' menu no

    # Completion for fzf-tab
    zstyle ':fzf-tab:*' fzf-min-height 50
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
    zstyle ':fzf-tab:complete:cat:*' fzf-preview 'bat --color=always --style=numbers --line-range=:500 $realpath'
    zstyle ':fzf-tab:complete:bat:*' fzf-preview 'bat --color=always --style=numbers --line-range=:500 $realpath'
}
