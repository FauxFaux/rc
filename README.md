# Installing on a clean Debian machine:

## Get the ability to type:

    su -c 'apt-get install sudo git zsh screen; adduser faux sudo; chsh -s /bin/zsh'

### # log out, log back in

    screen
    ssh-keygen; cat .ssh/id_*.pub

### # add key to gitolite

    git clone --recursive git@goeswhere.com:rc.git
    rc/install.sh

