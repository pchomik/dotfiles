# Load all functions
if [ -d ~/.config/zsh ]; then
  for i in ~/.config/zsh/*.sh; do
    if [ -r $i ]; then
      source $i
    fi
  done
fi

# Load functions
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
