function set_path() {
    # Extend PATH
    export PATH=$HOME/.local/bin:$PATH

    # Remove pyenv-win paths from PATH
    # export PATH=$(echo "$PATH" | tr ':' '\n' | grep -vE '/mnt/c/Users/[^/]+/\.pyenv.*?' | paste -sd ':' -)
}
