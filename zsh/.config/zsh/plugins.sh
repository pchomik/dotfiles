PLUGIN_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
OMZ_COMMIT="d1c04d8a33f9127d03b69617c5367db5ceebc8a7"
OMZ_RAW="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/${OMZ_COMMIT}"
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"

# Clone if missing. Wrong tag already on disk: rm -rf "$PLUGIN_HOME"
_ensure_plugin() {
    local repo=$1 tag=$2
    local dir="$PLUGIN_HOME/${repo##*/}"
    [[ -d $dir/.git ]] && return 0
    command -v git >/dev/null 2>&1 || return 1
    mkdir -p "$PLUGIN_HOME"
    GIT_TERMINAL_PROMPT=0 git clone --quiet --depth 1 --branch "$tag" \
        "https://github.com/${repo}.git" "$dir" || { rm -rf "$dir"; return 1; }
}

_ensure_omz_file() {
    local rel=$1 dest="$PLUGIN_HOME/ohmyzsh/$1"
    [[ -s $dest ]] && return 0
    command -v curl >/dev/null 2>&1 || return 1
    mkdir -p "${dest:h}"
    curl -fsSL "$OMZ_RAW/$rel" -o "$dest.tmp" && mv "$dest.tmp" "$dest" || {
        rm -f "$dest.tmp"
        return 1
    }
}

# Before compinit: extra fpath + OMZ aliases/completions.
function load_plugins() {
    mkdir -p "$ZSH_CACHE_DIR/completions"

    _ensure_plugin zsh-users/zsh-completions 0.35.0
    _ensure_plugin zsh-users/zsh-autosuggestions v0.7.1
    _ensure_plugin Aloxaf/fzf-tab v1.2.0
    _ensure_plugin zsh-users/zsh-syntax-highlighting 0.8.0

    [[ -d $PLUGIN_HOME/zsh-completions/src ]] &&
        fpath=($PLUGIN_HOME/zsh-completions/src $fpath)
    fpath=($ZSH_CACHE_DIR/completions $fpath)

    _ensure_omz_file lib/git.zsh
    _ensure_omz_file plugins/git/git.plugin.zsh
    _ensure_omz_file plugins/sudo/sudo.plugin.zsh
    _ensure_omz_file plugins/aws/aws.plugin.zsh
    _ensure_omz_file plugins/kubectl/kubectl.plugin.zsh
    _ensure_omz_file plugins/kubectx/kubectx.plugin.zsh
    _ensure_omz_file plugins/command-not-found/command-not-found.plugin.zsh
}

# After compinit + keymaps. Highlight last.
function load_plugin_widgets() {
    local f
    for f in \
        "$PLUGIN_HOME/ohmyzsh/lib/git.zsh" \
        "$PLUGIN_HOME/ohmyzsh/plugins/git/git.plugin.zsh" \
        "$PLUGIN_HOME/ohmyzsh/plugins/sudo/sudo.plugin.zsh" \
        "$PLUGIN_HOME/ohmyzsh/plugins/aws/aws.plugin.zsh" \
        "$PLUGIN_HOME/ohmyzsh/plugins/kubectl/kubectl.plugin.zsh" \
        "$PLUGIN_HOME/ohmyzsh/plugins/kubectx/kubectx.plugin.zsh" \
        "$PLUGIN_HOME/ohmyzsh/plugins/command-not-found/command-not-found.plugin.zsh"
    do
        [[ -r $f ]] && source "$f"
    done

    if command -v fzf >/dev/null 2>&1; then
        source <(fzf --zsh)
    fi

    [[ -r $PLUGIN_HOME/fzf-tab/fzf-tab.plugin.zsh ]] &&
        source "$PLUGIN_HOME/fzf-tab/fzf-tab.plugin.zsh"
    [[ -r $PLUGIN_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
        source "$PLUGIN_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh"
    [[ -r $PLUGIN_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
        source "$PLUGIN_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
}
