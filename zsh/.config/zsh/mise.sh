function load_mise() {
    if ! command -v mise >/dev/null 2>&1; then
        [[ -x "$HOME/.local/bin/mise" ]] && PATH="$HOME/.local/bin:$PATH"
    fi
    command -v mise >/dev/null 2>&1 || return 0

    eval "$(mise activate zsh)"

    # First machine: shims exist only after at least one install.
    if ! mise which starship >/dev/null 2>&1; then
        mise install
    fi

    command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
    command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh --cmd cd)"
}
