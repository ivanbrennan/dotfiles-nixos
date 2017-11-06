#!/bin/bash

if [[ ! -e "$HOME/.local/share/konsole/nord.colorscheme" ]]; then
  $DOTFILES/install/nord-konsole/install.sh
fi
