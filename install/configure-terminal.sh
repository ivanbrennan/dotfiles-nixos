#!/bin/bash

for name in marino nord ; do
  if [[ ! -e "$HOME/.local/share/konsole/$name.colorscheme" ]]; then
    $DOTFILES/install/$name-konsole/install.sh
  fi
done
