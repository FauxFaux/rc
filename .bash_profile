# the default umask is set in /etc/login.defs
umask 027

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

echo -ne '\e%G\e[?47h\e%G\e[?47l'

export TERM=linux

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

export PATH="$HOME/.cargo/bin:$PATH"
if [ -e /home/faux/.nix-profile/etc/profile.d/nix.sh ]; then . /home/faux/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
