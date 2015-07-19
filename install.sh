#!/bin/sh
set -e

# get some dotfiles into place
for f in rc/.*; do
	B=$(basename "$f")
	[ "$B" = "." -o "$B" = ".." -o "$B" = ".git" -o "$B" = ".gitmodules" -o "$B" = ".gitignore" ] && continue
	[ -L "$B" ] && rm "$B"
	ln -s "$f"
done

rc/i3status.conf.sh > .i3status.conf

# please let me actually use the machine
sudo apt-get install \
	connect-proxy \
	git \
	openssh-server \
	openssh-client \
	fail2ban \
	keychain \
	ncdu \
	sudo \
	tmux \
	vim-nox \
	vim-scripts \
	zsh

# this is actually a unix machine, look
sudo apt-get install \
	ack-grep \
	apache2-utils \
	apt-file \
	autossh \
	aria2 \
	buffer \
	bzip2 \
	colordiff \
	connect-proxy \
	dc \
	debian-goodies \
	debsums \
	deborphan \
	diffutils \
	dmidecode \
	dnsutils \
	dos2unix \
	e2fsprogs \
	encfs \
	etckeeper \
	gnupg \
	gzip \
	inotify-tools \
	iotop \
	jq \
	libxml2-utils \
	links \
	links2 \
	lockfile-progs \
	lsb-release \
	lzma \
	md5deep \
	molly-guard \
	mosh \
	moreutils \
	nano \
	netcat6 \
	netcat-traditional \
	nmap \
	ntp \
	pbzip2 \
	pwgen \
	pv \
	rkhunter \
	rsync \
	socat \
	strace \
	unrar \
	unzip \
	wbritish \
	whois \
	zip

# compilers, interpreters and media
sudo apt-get install \
	automake \
	build-essential \
	cmake \
	fish \
	flac \
	ghc \
	imagemagick \
	ipython \
	maven \
	openjdk-8-jdk \
	optipng \
	pyflakes \
	tidy

for failable in dig cgroup-lite; do
    sudo apt-get install $failable || true
done

sudo apt-get install \
    alsa-utils \
    dbus-x11 \
    i3 \
    network-manager \
    xautolock \
    xorg

sudo apt-get install \
    gedit \
    gnome-terminal \
    mplayer \
    mpd

