# Installing on a clean Debian machine:

## Get the ability to type:

    su -c 'apt-get install sudo git zsh screen; adduser faux sudo; chsh -s /bin/zsh'
    chsh -s /bin/zsh

### # log out, log back in

    screen
    git clone --recursive git@goeswhere.com:rc.git
    rc/install.sh

