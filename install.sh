#!/bin/sh
set -e

# get some dotfiles into place
for f in rc/.*; do
	B=$(basename "$f")
	[ "$B" = "." -o "$B" = ".." -o "$B" = ".git" -o "$B" = ".gitmodules" ] && continue
	[ -L "$B" ] && rm "$B"
	ln -s "$f"
done

# please let me actually use the machine
sudo apt-get install \
	openssh-server \
	openssh-client \
	fail2ban \
	most \
	ncdu \
	vim-nox \
	vim-scripts

# this is actually a unix machine, look
sudo apt-get install \
	ack-grep \
	apache2-utils \
	apt-file \
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
	etckeeper \
	gnupg \
	gzip \
	inotify-tools \
	iotop \
	links \
	links2 \
	lockfile-progs \
	lsb-release \
	lzma \
	md5deep \
	molly-guard \
	nano \
	netcat6 \
	netcat-traditional \
	nmap \
	pbzip2 \
	pwgen \
	pv \
	rkhunter \
	rsync \
	strace \
	unrar \
	unzip \
	wbritish \
	whois \
	zip

# compilers, interpreters and media
sudo apt-get install \
	build-essential \
	cmake \
	ffmpeg \
	fish \
	flac \
	ghc6 \
	imagemagick \
	ipython \
	maven2 \
	optipng \
	pyflakes \
	tidy

# might fail
sudo apt-get install \
	dig \
	| true
