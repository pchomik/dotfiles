# Load all functions
if [ -d ~/.config/zsh ]; then
  for i in ~/.config/zsh/*.sh; do
    if [ -r $i ]; then
      source $i
    fi
  done
fi

call_if_exists() {
    local func_name="$1"

    if type "$func_name" 1>/dev/null 2>/dev/null; then
        "$func_name"
    fi
}

call_if_exists set_proxy
set_path
load_mise
load_plugins
load_options
load_zstyle
load_pyenv
load_rust
set_aliases
set_keymap
load_plugin_widgets

# Automatically change tmux window name
# Executed on every prompt display
update_tmux_window_name() {
    if [ -n "$TMUX" ]; then
        tmux rename-window "${PWD##*/}"
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd update_tmux_window_name

export BROWSER=/usr/local/bin/brave


if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
