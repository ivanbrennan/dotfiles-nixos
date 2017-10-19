Read up on these files (from `/etc/X11/Xsession`):
```
OPTIONFILE=/etc/X11/Xsession.options

SYSRESOURCES=/etc/X11/Xresources
USRRESOURCES=$HOME/.Xresources

SYSSESSIONDIR=/etc/X11/Xsession.d
USERXSESSION=$HOME/.xsession
USERXSESSIONRC=$HOME/.xsessionrc
ALTUSERXSESSION=$HOME/.Xsession
```

Read `/etc/gdm3/Xsession`

[Why doesn't my ~/.bash_profile work?](https://unix.stackexchange.com/a/88149/47044)
> The file `~/.bash_profile` is read by bash when it is a login shell. That's what you get when you log in in text mode.
>
> When you log in under X, the startup scripts are executed by `/bin/sh`. On Ubuntu and Mint, `/bin/sh` is [dash](http://en.wikipedia.org/wiki/Debian_Almquist_shell), not bash. Dash and bash both have the same core features, but dash sticks to these core features in order to be fast and small whereas bash adds a lot of features at the cost of requiring more resources. It is common to use dash for scripts that don't need the extra features and bash for interactive use (though [zsh](http://en.wikipedia.org/wiki/Zsh) [has a lot of nicer features](https://unix.stackexchange.com/questions/983/what-features-are-in-zsh-and-missing-from-bash-or-vice-versa/985#985)).
>
> Most combinations of display manager (the program where you type your user name and password) and desktop environment read `~/.profile` from the login scripts in `/etc/X11/Xsession`, `/usr/bin/lightdm-session`, `/etc/gdm/Xsession` or whichever is applicable. So put your environment variable definitions in `~/.profile`. Make sure to use only syntax that dash supports.
>
> So what should you put where?
>
> * A good `.bash_profile` loads `.profile`, and loads `.bashrc` if the shell is interactive.
>     . ~/.profile
>     if [[ $- == *i* ]]; then . ~/.bashrc; fi
> * In `.profile`, put environment variable definitions, and other session settings such as `ulimit`.
> * In `.bashrc`, put bash interactive settings such as aliases, functions, completion, key bindings (that aren't in `.inputrc`), …
>
> See also [Difference between Login Shell and Non-Login Shell?](https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell/46856#46856) and [Alternative to `.bashrc`](https://unix.stackexchange.com/questions/3052/alternative-to-bashrc/3085#3085).

## Wayland vs X11, what's this about? Which am I using? What are the repurcussions?
To check which you're using, first run `loginctl` and find the `SESSION` number associated with your use.
Then run `loginctl show-session <number> -p Type`. For example, mine shows:
```
$ loginctl
   SESSION        UID USER             SEAT             TTY
         2       1000 ivan             seat0            /dev/tty2
        c1        120 gdm              seat0            /dev/tty1

2 sessions listed.
$ loginctl show-session 2 -p Type
Type=x11
```
So, I'm running X11, not wayland. Why is this the case? Well, the faq page for ubuntugnome says:
> Wayland support has been available since 15.04, however its not enabled by default just yet since it still needs some work. If you want to try it out install the gnome-session-wayland package.

This may be specific to Ubuntu-gnome, as the ArchWiki, in describing Gnome, says:
> The default display is Wayland instead of Xorg

On the other hand, checking on the ThinkPadX220 running Gnome on NixOS, it also reports x11 rather than Wayland. Of course, that's also an old machine, so maybe NixOS chose to go with Xorg because of the hardware?

See also:
- https://ubuntugnome.org/documentation/faq/
- https://askubuntu.com/questions/944073/try-out-wayland-on-ubuntu-gnome-17-04
- https://wiki.archlinux.org/index.php/GNOME
