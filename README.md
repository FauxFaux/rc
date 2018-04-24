# Installing on a clean Debian or Ubuntu machine:

```bash
sudo adduser faux
sudo adduser faux sudo
sudo apt install git zsh tmux connect-proxy
sudo chsh -s /bin/zsh faux
```

### # proxy busting

```bash
if [ ! -z "$socks_proxy" ]; then
    printf '[url "git@github.com:"]\n\tinsteadOf = "git://github.com/"\n\tinsteadOf = "https://github.com/"\n' >> ~/.gitconfig
    mkdir .ssh
    printf 'Host *.com\n\tProxyCommand /usr/bin/connect-proxy -S '$socks_proxy' %%h %%p\n' >> .ssh/config
fi
```

### # log out, log back in (with agent forwarding)

```bash
git clone --recursive git@github.com:FauxFaux/rc
tmux
rc/install.sh
```

### Other things that this doesn't setup:

 * `/etc/default/grub` remove `quiet` and `splash`.
 * `im-config` -> `xim`, not `ibus` (which doesn't do colemauk properly)
 * Stop Gnome apps prefering Firefox even if update-alternatives points elsewhere:
`for m in x-scheme-handler/http{,s} text/html; do gvfs-mime --set $m chromium-browser.desktop; done`
 * [Fixup word characters for gnome-terminal](https://bugs.launchpad.net/ubuntu/+source/gnome-terminal/+bug/1401207/comments/8),
which has forgotten how to support urls.
 * Consider `kernel.sysrq = 1` in `/etc/sysctl.d/10-magic-sysrq.conf`.
 * Ensure vconsoles (ctrl+alt+f2) are enabled; `NAutoVTs` in `logind.conf`
   or `ACTIVE_CONSOLES` in `/etc/default/console-setup`.
 * `/usr/share/xsessions/xsession.desktop`:

```ini
[Desktop Entry]
Name=Xsession
Exec=/etc/X11/Xsession
```

