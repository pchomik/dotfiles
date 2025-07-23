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
load_options
load_zinit
load_zstyle
load_go
load_pyenv
load_nvm
load_bun
set_aliases
set_keymap
