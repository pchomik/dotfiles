function load_rust() {
    if [ -d "$HOME/.cargo" ]; then
        . "$HOME/.cargo/env"
    fi
}
