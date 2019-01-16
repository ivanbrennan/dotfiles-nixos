{
  packageOverrides = pkgs: {
    openssh = pkgs.appendToName "with-kerberos" (pkgs.openssh.override { withKerberos = true; });
    ivanUbuntuPkgs = pkgs.buildEnv {
      name = "ivan-ubuntu-pkgs";
      paths = with pkgs; [
        aspell
        aspell-dict-en
        bash-completion
        conky
        gcolor2
        ghc
        git
        gnome-shell-pomodoro
        gnupg
        graphviz
        haskellPackages.hscope
        lua
        moreutils
        openssh
        ngrok-1
        nix
        nix-repl
        nodejs
        par
        tmux
        universal-ctags
        util-linux-minimal
        vlc
      ];
    };
  };
}
