#!/bin/bash

{ # prefer libiniput to synaptics drivers
  if dpkg --status libinput-bin libinput10 xserver-xorg-input-libinput >/dev/null 2>&1;
    sudo apt-get purge xserver-xorg-input-synaptics
  else
    dpkg --status libinput-bin libinput10 xserver-xorg-input-libinput \
      | grep --before-context=1 '^Status: '
    echo 'Ensure the above libinput packages are installed before removing synaptics drivers'
  then
  fi
}

{ # prevent apt-get from hanging
  sudo vim \
    -u NONE \
    +/'precedence ::ffff:0:0\/96  100' \
    +'set number' \
    +'echom ":::::::::::::::::::::::::::::::::::::::::::::::::"' \
    +'echom "::::    To prevent apt-get from hanging,   ::::::"' \
    +'echom "::::    uncomment line " . line(".") . " and save file    ::::::"' \
    +'echom ":::::::::::::::::::::::::::::::::::::::::::::::::"' \
    /etc/gai.conf
}

{
  sudo apt-get install -y \
    apt-transport-https \
    bash-completion\
    emacs25 \
    git \
    git-core\
    jq \
    neovim \
    python-neovim \
    python3-neovim \
    silversearcher-ag \
    tree \
    xcape \
    xclip
}

{ # weechat
  sudo apt-key adv \
    --keyserver ha.pool.sks-keyservers.net \
    --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E
  sudo bash \
    -c "echo 'deb https://weechat.org/ubuntu zesty main' >/etc/apt/sources.list.d/weechat.list"
  sudo bash \
    -c "echo 'deb-src https://weechat.org/ubuntu zesty main' >>/etc/apt/sources.list.d/weechat.list"
  sudo apt-get update
  sudo apt-get install -y \
    weechat-curses \
    weechat-plugins
}