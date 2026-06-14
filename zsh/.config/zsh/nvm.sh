function load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] || return 0

    __load_nvm() {
        unset -f nvm node npm npx pnpm yarn corepack
        \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    }

    __nvm_find_version_file() {
        local dir="$PWD"

        while [ "$dir" != "/" ]; do
            [ -f "$dir/.nvmrc" ] && {
                printf '%s\n' "$dir/.nvmrc"
                return 0
            }

            [ -f "$dir/.node-version" ] && {
                printf '%s\n' "$dir/.node-version"
                return 0
            }

            dir=${dir:h}
        done

        return 1
    }

    __maybe_load_nvm_for_dir() {
        local version_file
        version_file="$(__nvm_find_version_file)" || return 0

        __load_nvm
        nvm use --silent >/dev/null
    }

    nvm() {
        __load_nvm
        nvm "$@"
    }

    node() {
        __load_nvm
        node "$@"
    }

    npm() {
        __load_nvm
        npm "$@"
    }

    npx() {
        __load_nvm
        npx "$@"
    }

    pnpm() {
        __load_nvm
        pnpm "$@"
    }

    yarn() {
        __load_nvm
        yarn "$@"
    }

    corepack() {
        __load_nvm
        corepack "$@"
    }

    autoload -Uz add-zsh-hook
    add-zsh-hook chpwd __maybe_load_nvm_for_dir
    __maybe_load_nvm_for_dir
}
