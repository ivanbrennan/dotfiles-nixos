#!/bin/bash

set -eu

repo=$DOTFILES

shell_files=(
  "$repo/shell/bash_aliases"
  "$repo/shell/bash_colors.sh"
  "$repo/shell/bash_functions"
  "$repo/shell/bashrc"
  "$repo/shell/profile"
)

term_files=(
  "$repo/tmux/tmux.conf"
  "$repo/tmux/tmux-keys.conf"
)

home_files=(
  "${shell_files[@]}"
  "${term_files[@]}"
)

config_files=(
  "$repo/git"
)

main() {
  make_home_symlinks
  make_config_symlinks
}

make_home_symlinks() {
  for src in "${home_files[@]}"; do
    link="$HOME/.$(basename "$src")"
    make_symlink "$src" "$link"
  done
}

make_config_symlinks() {
  for src in "${config_files[@]}"; do
    link="$HOME/.config/$(basename "$src")"
    make_symlink "$src" "$link"
  done
}

already_exists() {
  # non-empty && not a symlink
  [ -s "$1" ] && [ ! -L "$1" ]
}

make_symlink() {
  local src=$1 link=$2

  if already_exists "$link"; then
    backup="${link}-backup-$(date +%s)"
    echo "$link already exists. Backing up to $backup"
    mv -i "$link" "$backup"
  fi

  ln -svnf "$src" "$link" | grep -Fe '->'
}

main
