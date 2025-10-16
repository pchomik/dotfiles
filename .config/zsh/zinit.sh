function load_zinit() {
    # Set the directory we want to store zinit and plugins
    ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

    # Download Zinit, if it's not there yet
    if [ ! -d "$ZINIT_HOME" ]; then
        mkdir -p "$(dirname $ZINIT_HOME)"
        git clone https://github.com/zdharma-continuum/zinit.git --branch "v3.14.0" "$ZINIT_HOME"
    fi

    # Source/Load zinit
    source "${ZINIT_HOME}/zinit.zsh"

    # Load starship prompt
    zinit ice as"command" from"gh-r" as"v1.23.0" \
        atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
        atpull"%atclone" src"init.zsh"
    zinit light starship/starship

    # Load fzf
    zinit wait"0b" lucid light-mode for \
        id-as'fzf' \
        as"program" \
        from"gh-r" \
        ver"v0.66.0" \
        nocompile \
        @junegunn/fzf

    zinit wait"0c" as"completion" light-mode lucid for \
        id-as'fzf-completion' mv'fzf-completion -> _fzf' https://github.com/junegunn/fzf/blob/v0.66.0/shell/completion.zsh

    zinit wait"0d" lucid light-mode for \
        id-as"fzf-keybindings" https://github.com/junegunn/fzf/blob/v0.66.0/shell/key-bindings.zsh

    # Load zoxide plugin
    zinit ice from"gh-r" ver"v0.9.8" as"program" \
        atload'eval "$(zoxide init zsh --cmd cd)"'
    zinit light ajeetdsouza/zoxide

    # Load bat plugin
    zinit ice as"program" from"gh-r" ver"v0.25.0" pick"bat*/bat" \
        mv"bat*/autocomplete/bat.zsh -> _bat" \
        fpath"bat*/autocomplete" # this should be atclone'...' but for now it works
    zinit light sharkdp/bat

    # Load eza plugin
    zinit ice as"program" from"gh-r" at"v0.23.4" \
        pick"eza*/eza" \
        mv"eza*/completions/zsh/_eza -> _eza" \
        fpath"eza*/completions/zsh"
    zinit light eza-community/eza

    # Add other zsh plugins
    zinit ice ver"0.8.0"
    zinit light zsh-users/zsh-syntax-highlighting

    zinit ice ver"0.35.0"
    zinit light zsh-users/zsh-completions

    zinit ice ver"v0.7.1"
    zinit light zsh-users/zsh-autosuggestions

    zinit ice ver"v1.2.0"
    zinit light Aloxaf/fzf-tab

    # Add in snippets
    # Pin Oh My Zsh plugins to a specific tag
    zinit ice at"d1c04d8a33f9127d03b69617c5367db5ceebc8a7"
    zinit wait light-mode lucid for \
        OMZL::git.zsh \
        OMZP::git \
        OMZP::sudo \
        OMZP::aws \
        OMZP::kubectl \
        OMZP::kubectx \
        OMZP::command-not-found
}
