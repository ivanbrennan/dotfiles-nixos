#!/usr/bin/env bash

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
    rbenv \
    ruby-build \
    silversearcher-ag \
    tree \
    xcape \
    xsel
}

pushd ~/Downloads
curl -O https://downloads.slack-edge.com/linux_releases/slack-desktop-3.0.5-amd64.deb
sudo dpkg -i slack-desktop-2.8.1-amd64.deb 
sudo apt-get install -f
popd

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

# apt-file
# Use-case: A build fails due to some missing dependency.
# The failure message calls out the actual file that's missing.
# apt-file performs a reverse-lookup, identifying the missing
# package by the name of a file contained within it.
# E.g.
#  $ stack build
#  <command line>: can't load .so/.DLL for: libtinfo.so (libtinfo.so: cannot open shared object file: No such file or directory)
#  $ sudo apt-file search libtinfo.so
#  $ sudo apt-get install libtinfo-dev
#  $ stack build
{
  sudo apt-get install apt-file -y
  sudo apt-file update
}
