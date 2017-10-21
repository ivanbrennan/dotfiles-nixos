{ packageOverrides = pkgs: { openssh = pkgs.appendToName "with-kerberos" (pkgs.openssh.override { withKerberos = true; }); }; }
