function load_bun {
    if [ -d "$HOME/.bun" ]; then
        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"

        [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
    fi
}
