
#[ Completion ]################################################################
zstyle :compinstall filename '/home/faux/.zshrc'

#[ Prompt ]####################################################################
autoload colors && colors

precmd() {
	ref=$(git symbolic-ref HEAD 2> /dev/null || echo "")
	ref=${ref#refs/heads/}
	RPROMPT="%{$reset_color$fg_bold[grey]%}$ref%{$reset_color%} %(?..%{$fg_bold[red]%}%?%{$reset_color%}) [ %T ]"
}

if [ $UID -eq 0 ]; then
	PROMPT="%{$reset_color$fg_bold[red]%}%n@%B%m%b:%~%# "
else
	PROMPT="%{$fg_bold[blue]%}%n@%m%{$reset_color%}:%{$fg[red]%}%~%{$reset_color%}%# "
fi

RPROMPT="%{$reset_color$fg_bold[grey]%}$ref%{$reset_color%} %(?..%{$fg_bold[red]%}%?%{$reset_color%}) [ %T ]"

#[ Aliases ]###################################################################
alias acs="apt-cache search"
alias acsh="apt-cache show"
alias acsno="apt-cache search --names-only"
alias backus="ssh -t -X faux@backus.uwcs.co.uk screen -A -d -RR"
alias cd..="cd .."
alias codd="ssh -t -X faux@uwcs.co.uk screen -A -d -RR"
alias d="du --si --max-depth=1"
alias e="gvim"
alias g="grep"
alias joshua="ssh -t -X csuebl@joshua.dcs.warwick.ac.uk screen -A -d -RR"
alias ls="ls --color=auto -C"
alias l="ls -C"
alias more="less" # (More or less.)
alias s="sudo"
alias sagi="sudo apt-get install"
alias sagr="sudo apt-get remove"
alias sagu="sudo apt-get update"
alias sagup="sudo apt-get upgrade"
alias sc="screen -Dr"
alias se="sudo gvim"
alias sl="ls"
alias syslog="sudo tail -n $LINES -f /var/log/syslog"
alias stf="sudo tail -f"
alias sv="sudo vim"
alias tf="tail -f"
alias v="vim"
alias :q="exit"
alias :w='echo \"$PWD\" "$RANDOM"L, "$RANDOM"C written'

alias -g ...='../..'
alias -g ....='../../../'


#[ Aliases ]###################################################################

cdt () { BASE=/var/tmp/$LOGNAME$(($(date +%y%m%d))); i=0; while [ -e $BASE.$i ] || ! mkdir $BASE.$i; do i=$((i+1)); done; cd $BASE.$i }

editzshrc() {
	vim ~/.zshrc
	source ~/.zshrc
}

kernel() {
	make-kpkg --rootcmd fakeroot --append_to_version=-faux --initrd kernel_image
}

esvn () {
	[[ -z $1 ]] && { echo "$0: error: specify file to edit"; return 1; }
	gvim --nofork $1 && { svn add Makefile; svn diff $1 2>&1 | gvim -d - ; svn commit $1 }
}

ediff () {
	TEMPFILE=$(tempfile -pediff -s.diff)
	svn diff > $TEMPFILE
	gvimdiff -M $TEMPFILE # edit with no modifications allowed
}

pushdotfilesto() {
	[[ -z $1 ]] && { echo "$0: error: specify location"; return 1; }
	scp ~/.vimrc ~/.screenrc ~/.zshrc "${1}":
}

f() {
	[[ -z $1 ]] && { echo "$0: error: specify search string"; return 1 }
	find . | egrep -v "(.git|.svn-base|.svn|.bzr)" | xargs grep $1
}


++ () {
	[[ -z $1 ]] && { echo "$0: Compiles and runs a C++ program. usage: $0 filename.cpp" }
	g++ -std=c++98 -pedantic-errors -Wall -Werror -Wfatal-errors -Wwrite-strings -ftrapv -fno-merge-constants -fno-nonansi-builtins -fno-gnu-keywords -fstrict-aliasing "$1" -o"$(basename "$1" .cpp)" && "$(dirname "$1")"/"$(basename "$1" .cpp)"
}


#[ Debian ]##################################################################==

acsd() {
	[[ -z $1 ]] && { echo "$0: error: invalid search string"; return 1 }
	apt-cache search $1 | grep -i "$1"
}

res() {
	[[ -z $1 ]] && { echo "$0: error: please specify a daemon"; return 1 }
	sudo /etc/init.d/$1 restart
}

rel() {
	[[ -z $1 ]] && { echo "$0: error: please specify a daemon"; return 1 }
	sudo /etc/init.d/$1 reload
}

upload_to() {
     scp -l 120 -C ${1} "${2}:${3}" && echo "\n${4}${1}"
}

stov() {
    [[ -z $1 ]] && { echo "$0: error: please specify a filename"; return 1 }
    upload_to "${@}" "faux@uwcs.co.uk" "public_html/b/" "http://faux.uwcs.co.uk/b/"
}

deepkeys() { 
	curl 'http://pgp.cs.uu.nl/mk_path.cgi?FROM=A482EE24&TO='$1'&PATHS=trust+paths' | egrep -o '<SMALL>[A-F0-9]{8}</SMALL>' | perl -ne 's#</?SMALL>##g; print' | sort | uniq | xargs gpg --recv-keys 
}

bedword() { printf "$(printf "\\\x%02x\\\x%02x\\\x%02x\\\x%02x" $(($1&0xff)) $((($1>>8)&0xff)) $((($1>>16)&0xff)) $((($1>>24)&0xff)))" }

norprompt() {
	precmd() {}
	unset RPROMPT
}

setopt incappendhistory autocd extendedglob nomatch notify interactivecomments

autoload -Uz compinit
compinit

unsetopt beep

# Move to end of line in history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '\e[A' history-beginning-search-backward-end
bindkey '\e[B' history-beginning-search-forward-end

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#[ Exports ]###################################################################
export EDITOR="vim"
# git--
#export LESS="-cgiFx4M"
export PAGER="most"
export PATH="$HOME/bin/:$HOME/.cabal/bin:$HOME/usr/bin:$PATH"
export PYTHONPATH=$PYTHONPATH:$HOME/lib/python

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "[5~" beginning-of-history
bindkey "[6~" end-of-history
bindkey "^[[3~" delete-char
bindkey -M vicmd '^r' history-incremental-search-backward
bindkey -M viins '^r' history-incremental-search-backward

autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

if [ -f ~/.zshlocal ]; then
	. ~/.zshlocal
fi

msql() { mysql -u$1 -p$1 -D$1 }
gk() { gitk "$@" & }
gka() { gk --all $(git log -g --format="%h" -50) "$@" }
hometime() { (printf "echo "; fgrep gnome-screensaver-dialog /var/log/messages | fgrep "[$USER]" | grep "$(date +'%b %e')" | head -n1 | awk '{print $3}' | sed 's/^0/ /;s/../$((&+8))/') | sh }
jarr() { jar tf $1 | tee o && grep '[wj]ar$' o | while read f; do [ ! -e $f ] && jar xf $1 $f && jar tf $f && rm $f; done }
decompressjar() { MWD=$(pwd) && DIR=$(mktemp -d) && (cd $DIR && jar xf $MWD/$1) && rm $1 && (cd $DIR && jar 0cf $MWD/$1 .) && rm -rf $DIR; }
decompressjarstream() { DIR=$(mktemp -d) && (cd $DIR && jar x && jar 0c .) && rm -rf $DIR; }

ignore() { for f in "$@"; do echo $f >> .gitignore; done }
