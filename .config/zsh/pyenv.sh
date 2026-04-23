function __load_pyenv_shell_integration() {
    unset -f pyenv
    eval "$(command pyenv init - zsh)"
    eval "$(command pyenv virtualenv-init -)"
}

function load_pyenv() {
    if [ -d "$HOME/.pyenv" ]; then
        export PYENV_VIRTUALENV_DISABLE_PROMPT=1
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

        pyenv() {
            __load_pyenv_shell_integration
            pyenv "$@"
        }
    fi
}
