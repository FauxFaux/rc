#!/bin/zsh
set -e

# Copy the standard dot files into the correct place
RCPATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
for f in rc/.*; do

  B=$(basename "$f")
  [ "$B" = "." -o "$B" = ".." -o "$B" = ".git" -o "$B" = ".gitmodules" -o "$B" = ".gitignore" ] && continue
  [ -L "$B" ] && rm "$B"
  
  SRC=$(readlink -f "$f")
  DEST=$(pwd)/$(basename "$f")
  
  # Ensure that the symbolic links are cleaned up
  [ -L "$B" ] && rm "$B"

  # Move any non-symbolic links to the 'backup' file
  [ -e "$DEST" ] && mv "$DEST" "$DEST.backup"

  ln -s "$SRC" "$DEST"
done

# Sway uses an XDG config directory rather than a top-level dotfile.
mkdir -p "$HOME/.config"
SRC=$(readlink -f rc/sway)
DEST="$HOME/.config/sway"
[ -L "$DEST" ] && rm "$DEST"
[ -e "$DEST" ] && mv "$DEST" "$DEST.backup"
ln -s "$SRC" "$DEST"

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
	etckeeper \
	gnupg \
	gzip \
	inotify-tools \
	iotop \
	htop \
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
	netcat-traditional \
	nmap \
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
	imagemagick \
	optipng \
	tidy

sudo apt-get install \
    alsa-utils \
    dbus-x11 \
    sway \
    rofi \
    xdotool \
    network-manager \
    xautolock \
    xorg

sudo apt-get install \
    gedit \
    gnome-terminal \
    mpv

