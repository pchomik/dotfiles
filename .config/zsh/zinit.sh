function load_zinit() {
    # Set the directory we want to store zinit and plugins
    ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

    # Download Zinit, if it's not there yet
    if [ ! -d "$ZINIT_HOME" ]; then
        mkdir -p "$(dirname $ZINIT_HOME)"
        git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    fi

    # Source/Load zinit
    source "${ZINIT_HOME}/zinit.zsh"

    # Load starship prompt
    zinit ice as"command" from"gh-r" \
        atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
        atpull"%atclone" src"init.zsh"
    zinit light starship/starship

    # Load fzf
    zinit wait"0b" lucid light-mode for \
        id-as'fzf' \
        as"program" \
        from"gh-r" \
        nocompile \
        @junegunn/fzf

    zinit wait"0c" as"completion" light-mode lucid for \
        id-as'fzf-completion' mv'fzf-completion -> _fzf' https://github.com/junegunn/fzf/blob/master/shell/completion.zsh

    zinit wait"0d" lucid light-mode for \
        id-as"fzf-keybindings" https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh

    # Load zoxide plugin
    zinit ice from"gh-r" as"program" \
        atload'eval "$(zoxide init zsh --cmd cd)"'
    zinit light ajeetdsouza/zoxide

    # Load bat plugin
    zinit ice as"program" from"gh-r" pick"bat*/bat" \
        mv"bat*/autocomplete/bat.zsh -> _bat" \
        fpath"bat*/autocomplete"
    zinit light sharkdp/bat

    # Load eza plugin
    zinit ice as"program" from"gh-r" \
        pick"eza*/eza" \
        mv"eza*/completions/zsh/_eza -> _eza" \
        fpath"eza*/completions/zsh"
    zinit light eza-community/eza

    # Add other zsh plugins
    zinit wait light-mode lucid for \
        zsh-users/zsh-syntax-highlighting \
        zsh-users/zsh-completions \
        zsh-users/zsh-autosuggestions \
        Aloxaf/fzf-tab

    # Add in snippets
    zinit wait light-mode lucid for \
        OMZL::git.zsh \
        OMZP::git \
        OMZP::sudo \
        OMZP::archlinux \
        OMZP::aws \
        OMZP::kubectl \
        OMZP::kubectx \
        OMZP::command-not-found
}



