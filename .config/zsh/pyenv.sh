function load_pyenv() {
    if [ -d "$HOME/.pyenv" ]; then
        export PYENV_VIRTUALENV_DISABLE_PROMPT=1
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init - zsh)"
        eval "$(pyenv virtualenv-init -)"
    fi
}

