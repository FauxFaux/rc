# Installing on a clean Debian machine:

## Get the ability to type:

    su -c 'apt-get install sudo git zsh screen connect-proxy; adduser faux sudo; chsh -s /bin/zsh'
    chsh -s /bin/zsh

### # proxy busting

    if [ ! -z "$socks_proxy" ]; then
        printf '[url "git@github.com:"]\n\tinsteadOf = "git://github.com/"\n\tinsteadOf = "https://github.com/"\n' >> ~/.gitconfig
        mkdir .ssh
        printf 'Host *.com\n\tProxyCommand /usr/bin/connect-proxy -S '$socks_proxy' %%h %%p\n' >> .ssh/config
    fi

### # log out, log back in (with agent forwarding)

    git clone --recursive git@goeswhere.com:rc.git
    screen
    rc/install.sh

