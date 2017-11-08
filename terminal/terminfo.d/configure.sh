dir=$HOME/Development/resources/dotfiles-nixos/terminal/terminfo.d
files=( alacritty.info
        tmux.terminfo
        tmux-256color.terminfo
        xterm-256color.terminfo )

for file in "${files[@]}"; do
  tic -x -o $dir/terminfo $dir/$file
done

ln -svnf $dir/terminfo $HOME/.terminfo
