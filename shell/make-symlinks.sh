#!/bin/sh

set -eu

repo=$DOTFILES

shell_files=(
  "$repo/shell/bash_aliases"
  "$repo/shell/bash_colors.sh"
  "$repo/shell/bash_functions"
  "$repo/shell/bashrc"
)

main() {
  for src in "${shell_files[@]}"; do
    link="$HOME/.$(basename "$src")"

    if already_exists "$link"; then
      backup="${link}-backup-$(date +%s)"
      echo "$link already exists. Backing up to $backup"
      mv -i "$link" "$backup"
    fi

    make_symlink "$src" "$link"
  done
}

already_exists() {
  # non-empty && not a symlink
  [ -s "$1" ] && [ ! -L "$1" ]
}

make_symlink() {
  local src=$1 link=$2
  ln -svnf "$src" "$link" | grep -Fe '->'
}

main
