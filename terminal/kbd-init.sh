#!/usr/bin/env bash

if [ ! -e /etc/default/keyboard.backup ]; then
  sudo cp /etc/default/keyboard{,.backup}
  sudo chmod \
    --reference=/etc/default/keyboard \
    /etc/default/keyboard.backup
fi

sudo sed -i.old \
  "s/^XKBOPTIONS=.\+$/XKBOPTIONS=\"ctrl:nocaps\"/" \
  /etc/default/keyboard

sudo chmod \
  --reference=/etc/default/keyboard.old \
  /etc/default/keyboard

sudo rm /etc/default/keyboard.old
