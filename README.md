# Installing on a clean Debian or Ubuntu machine:

## Get the ability to type:

```bash
su -c 'apt-get update && apt-get upgrade -y; apt-get install sudo git zsh tmux connect-proxy; adduser faux sudo; chsh -s /bin/zsh'
chsh -s /bin/zsh
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
git clone --recursive git@goeswhere.com:rc.git
tmux
rc/install.sh
```

### Other things that this doesn't setup:

 * `/etc/default/grub` remove `quiet` and `splash`.
 * `im-config` -> `xim`, not `ibus` (which doesn't do colemauk properly)
 * `/usr/share/xsessions/xsession.desktop`:

```ini
[Desktop Entry]
Name=Xsession
Exec=/etc/X11/Xsession
```

