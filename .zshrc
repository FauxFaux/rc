
#[ Completion ]################################################################
zstyle :compinstall filename '/home/faux/.zshrc'

#[ Prompt ]####################################################################
autoload colors && colors

precmd() {
	if [[ "$(pwd)" == /smb* ]]; then
		ref=/smb
	else
		ref=$(git symbolic-ref HEAD 2> /dev/null || echo "")
		ref=${ref#refs/heads/}
	fi
	RPROMPT="%{$reset_color$fg_bold[grey]%}$ref%{$reset_color%} %(?..%{$fg_bold[red]%}%?%{$reset_color%}) [ %T ]"
	printf '\e]82;'$(pwd)'\007'
}

if [ $UID -eq 0 ]; then
	PROMPT="%{$reset_color$fg_bold[red]%}%n@%B%m%b:%~%# "
else
	PROMPT="%{$fg_bold[blue]%}%n@%m%{$reset_color%}:%{$fg[red]%}%~%{$reset_color%}%# "
fi

RPROMPT="%{$reset_color$fg_bold[grey]%}$ref%{$reset_color%} %(?..%{$fg_bold[red]%}%?%{$reset_color%}) [ %T ]"

# make the ssh agent available at a consistent path, for screen'd shells
if [[ -o login && ! -z "$SSH_AUTH_SOCK" ]]; then
	rm -f ~/.ssh/auth_sock && ln -s $SSH_AUTH_SOCK ~/.ssh/auth_sock
fi

#[ Aliases ]###################################################################
alias :q="exit"
alias :w='echo \"$PWD\" "$RANDOM"L, "$RANDOM"C written'
alias acp="apt-cache policy"
alias acs="apt-cache search"
alias acsh="apt-cache show"
alias acsno="apt-cache search --names-only"
alias cd..="cd .."
alias l="ls -C"
alias ls="ls --color=auto -C"
alias more="less" # (More or less.)
alias rsyncpp='rsync -av --partial --progress'
alias s="sudo"
alias sagi="sudo apt-get install"
alias sagr="sudo apt-get remove"
alias sagu="sudo apt-get update"
alias sagup="sudo apt-get upgrade"
alias sagdup="sudo apt-get dist-upgrade"
alias sc="screen -Dr"
alias sl="ls"
alias sx="screen -x"
alias v="vim"

arm() { sudo sudo -u debian-tor arm }
cdt () { BASE=/var/tmp/$LOGNAME$(($(date +%y%m%d))); i=0; while [ -e $BASE.$i ] || ! mkdir $BASE.$i; do i=$((i+1)); done; cd $BASE.$i }
decompressjar() { MWD=$(pwd) && DIR=$(mktemp -d) && (cd $DIR && jar xf $MWD/$1) && rm $1 && (cd $DIR && jar 0cf $MWD/$1 .) && rm -rf $DIR; }
decompressjarstream() { DIR=$(mktemp -d) && (cd $DIR && jar x && jar 0c .) && rm -rf $DIR; }
gk() { gitk "$@" &disown }
gka() { gk --all $(git log -g --format="%h" -50) "$@" }
hometime() { (printf "echo "; fgrep gnome-screensaver-dialog /var/log/syslog | fgrep "[$USER]" | grep "$(date +'%b %e')" | head -n1 | awk '{print $3}' | sed 's/^0/ /;s/../$((&+8))/') | sh }
ignore() { for f in "$@"; do echo $f >> .gitignore; done }
jarr() { jar tf $1 | tee o && grep '[wj]ar$' o | while read f; do [ ! -e $f ] && jar xf $1 $f && jar tf $f && rm $f; done }
msql() { mysql -u$1 -p$1 -D$1 $2 $3 $4 $5 } # yes, that's terrible
mt() { mvn clean && mvn test "$@" }
nomavennamespace() { sed 's,http://maven.apache.org/[Px][Os][Md]/[^"]*",",g' }
quotes(){ echo "select concat(quoteid,': < ',nick,'> ',message) from _objectdb_plugins_quote_quoteline where quoteid in (select quoteid from _objectdb_plugins_quote_quoteline where nick='$1');"|mysql -uchoob_scripts -Dchoob|tr -d '[\000-\011]'|perl -pe '$p=$_;$p=~s/:.*//;if($p ne $l){$l=$p;print"\n";}' | sed 1d;}
sortpom() {  mvn com.google.code.sortpom:maven-sortpom-plugin:sort -Dsort.nrOfIndentSpace=4 -Dsort.sortPlugins=groupId,artifactId -Dsort.sortDependencies=scope,groupId,artifactId }
sparse() { dd if=/dev/zero of=$1 bs=1M count=1 skip=$2 }
wu() { (find & git ls-files -s & git log -5 & mvn pre-clean & git status & git fetch &) > /dev/null }

editzshrc() {
	vim ~/.zshrc
	source ~/.zshrc
}

kernel() {
	make-kpkg --rootcmd fakeroot --append_to_version=-faux --initrd kernel_image
}

++ () {
	[[ -z $1 ]] && { echo "$0: Compiles and runs a C++ program. usage: $0 filename.cpp" }
	g++ -std=c++98 -pedantic-errors -Wall -Werror -Wfatal-errors -Wwrite-strings -ftrapv -fno-merge-constants -fno-nonansi-builtins -fno-gnu-keywords -fstrict-aliasing "$1" -o"$(basename "$1" .cpp)" && "$(dirname "$1")"/"$(basename "$1" .cpp)"
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

fpath=(~/rc/zsh-git-escape-magic $fpath)

autoload -Uz git-escape-magic
git-escape-magic

autoload -Uz compinit
compinit

. ~/rc/zsh-hardcopy

unsetopt beep

# Move to end of line in history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey -e # bug in Debian wheezy until zsh 5,
           # up arrow in vi-mode puts the cursor in the wrong place

bindkey '\e[A' history-beginning-search-backward-end
bindkey '\e[B' history-beginning-search-forward-end

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#[ Exports ]###################################################################
export EDITOR="vim"
export REPORTTIME=10
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

echo -ne '\e%G\e[?47h\e%G\e[?47l'


