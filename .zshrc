
#[ Completion ]################################################################
fpath+=~/.zfunc
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
#	printf '\e]82;'$(pwd)'\007'
}

if [ $UID -eq 0 ]; then
	PROMPT="%{$reset_color$fg_bold[red]%}%n@%B%m%b:%~%# "
else
	PROMPT="%{$fg_bold[blue]%}%n@%m%{$reset_color%}:%{$fg[red]%}%~%{$reset_color%}%# "
fi

RPROMPT="%{$reset_color$fg_bold[grey]%}$ref%{$reset_color%} %(?..%{$fg_bold[red]%}%?%{$reset_color%}) [ %T ]"

MY_AUTH_SOCK=~/.ssh/auth_sock
# make the ssh agent available at a consistent path, for screen'd shells
if [[ -o login && ! -z "$SSH_AUTH_SOCK" && -z "$TMUX" ]]; then
	rm -f $MY_AUTH_SOCK && ln -s $SSH_AUTH_SOCK ~/.ssh/auth_sock
fi

if [ -e $MY_AUTH_SOCK ]; then
    export SSH_AUTH_SOCK=$MY_AUTH_SOCK
fi

#[ Aliases ]###################################################################
alias :q="exit"
alias :w='echo \"$PWD\" "$RANDOM"L, "$RANDOM"C written'
alias acp="apt-cache policy"
alias acs="apt-cache search"
alias acsh="apt-cache show"
alias acshs="apt-cache showsrc"
alias acsno="apt-cache search --names-only"
alias arm="sudo sudo -u debian-tor arm"
alias cd..="cd .."
alias clip="xclip -selection clipboard"
alias cre="cargo run --example"
alias encsetup='encfs ~/.encrypted/ ~/secure'
alias g=git
alias gb='gradle build'
alias l="ls -C"
alias ls="ls --color=auto -C"
alias more="less" # (More or less.)
alias nomavennamespace="sed 's,http://maven.apache.org/[Px][Os][Md]/[^\"]*\",\",g'"
alias rsyncpp='rsync -av --partial --progress'
alias s="sudo"
alias saup="sudo apt upgrade"
alias sai="sudo apt install"
alias sau="sudo apt update"
alias sc="tmux attach -d"
alias setroot="xsetroot -solid grey17"
alias sl="ls"
alias sortpom="mvn com.google.code.sortpom:maven-sortpom-plugin:sort -Dsort.nrOfIndentSpace=4 -Dsort.sortPlugins=groupId,artifactId -Dsort.sortDependencies=scope,groupId,artifactId"
alias suspend="dbus-send --system --print-reply --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend"
alias sx="screen -x"
alias v="vim"

bedword() { printf "$(printf "\\\x%02x\\\x%02x\\\x%02x\\\x%02x" $(($1&0xff)) $((($1>>8)&0xff)) $((($1>>16)&0xff)) $((($1>>24)&0xff)))" }
cargo-up() { nice cargo update && nice cargo check --all && nice cargo build --all && nice cargo test --all }
ccache-env() { export PATH=/usr/lib/ccache:$PATH CC='ccache gcc' CXX='ccache g++' }
decompressjar() { MWD=$(pwd) && DIR=$(mktemp -d) && (cd $DIR && jar xf $MWD/$1) && rm $1 && (cd $DIR && jar 0cf $MWD/$1 .) && rm -rf $DIR; }
decompressjarstream() { DIR=$(mktemp -d) && (cd $DIR && jar x && jar 0c .) && rm -rf $DIR; }
deepkeys() { curl 'http://pgp.cs.uu.nl/mk_path.cgi?FROM=A482EE24&TO='$1'&PATHS=trust+paths' | egrep -o '<SMALL>[A-F0-9]{8}</SMALL>' | perl -ne 's#</?SMALL>##g; print' | sort | uniq | xargs gpg --recv-keys }
editzshrc() { vim ~/.zshrc && source ~/.zshrc }
gk() { gitk "$@" &disown }
gka() { gk --all $(git log -g --format="%h" -50) "$@" }
ghfc() { git clone --recursive https://github.com/FauxFaux/$1 }
hometime() { (printf "echo "; fgrep gnome-screensaver-dialog /var/log/syslog | fgrep "[$USER]" | grep "$(date +'%b %e')" | head -n1 | awk '{print $3}' | sed 's/^0/ /;s/../$((&+8))/') | sh }
ignore() { for f in "$@"; do echo $f >> .gitignore; done }
jarr() { jar tf $1 | tee o && grep '[wj]ar$' o | while read f; do [ ! -e $f ] && jar xf $1 $f && jar tf $f && rm $f; done }
kernel() { make-kpkg --rootcmd fakeroot --append_to_version=-$USER --initrd kernel_image }
msql() { mysql -u$1 -p$1 -D$1 $2 $3 $4 $5 } # yes, that's terrible
mt() { mvn clean "$@" && mvn test "$@" }
norprompt() { precmd() {}; unset RPROMPT }
quotes(){ echo "select concat(quoteid,': < ',nick,'> ',message) from _objectdb_plugins_quote_quoteline where quoteid in (select quoteid from _objectdb_plugins_quote_quoteline where nick='$1');"|mysql -uchoob_scripts -Dchoob|tr -d '[\000-\011]'|perl -pe '$p=$_;$p=~s/:.*//;if($p ne $l){$l=$p;print"\n";}' | sed 1d;}
rss() { for feed in 'http://probablyfine.co.uk/feed/' 'http://blog.suriar.net/feeds/posts/default?alt=rss'; do curl -s $feed | xqillac 'for $x in //item return (data($x/title),data($x/link),data($x/pubDate))' | while read title; read url; read date; do echo $(date -d"$date" +%s) $url $title; done; done | sort -n | tail -n4 | cut -d\  -f2- }
sparse() { dd if=/dev/zero of=$1 bs=1M count=1 skip=$2 }
svncd() { svn up --depth=immediates "$@" && cd "$1" }
svnco() { svn up --set-depth=infinity "$@" }
svnls() { svn up --set-depth=immediates "$@" }
svntrunk() { find "$@" -name trunk -exec svn up --set-depth=infinity {} + }
wu() { (find & git ls-files -s & git log -5 & mvn pre-clean & git status & git fetch &) > /dev/null }

++ () {
	[[ -z $1 ]] && { echo "$0: Compiles and runs a C++ program. usage: $0 filename.cpp" }
	g++ -std=c++98 -pedantic-errors -Wall -Werror -Wfatal-errors -Wwrite-strings -ftrapv -fno-merge-constants -fno-nonansi-builtins -fno-gnu-keywords -fstrict-aliasing "$1" -o"$(basename "$1" .cpp)" && "$(dirname "$1")"/"$(basename "$1" .cpp)"
}

rword() {
    L=~/.cache/words
    [ -f $L ] || (
        </usr/share/dict/words LANG=C egrep '^[a-z]{4,8}$' | egrep -v 'ing$|ed$|s$' > $L
    )
    shuf -n1 $L
}

cdt () {
    BASE=/var/tmp/$LOGNAME$(date +%y%m%d)
    while true; do
        w=$(rword)
        if ! [ -e $BASE.$w ]; then
            mkdir $BASE.$w
            break
        fi
    done
    cd $BASE.$w
}


svndeepen() {
    find "$@" -type d -empty -not \( \
        -wholename '*/tags/*' -o \
        -wholename '*/tags-*/*' -o \
        -wholename '*/branches/*' -o \
        -wholename '*/branches-*/*' -o \
        -wholename '*/trunk*' -o \
        -wholename '*/releases/*' \
    \) -exec svn up --set-depth=immediates {} + }


setopt incappendhistory autocd extendedglob nomatch notify interactivecomments

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
HISTSIZE=50000
SAVEHIST=50000

#[ Exports ]###################################################################
export EDITOR="vim"
export REPORTTIME=10

# -i case insenstive searching
# -N number lines
# -w track paging with line hilights
# -q no bell
# -z track paging by not paging a whole page
# -g hilight only the current match during search
# -e quit at eof
# -M more verbose
# -X disable some termcap, e.g. clearing (?)
# -F quit if less than one screen
# -R allow colour display codes through
# -P set the prompt
export LESS='-i -w -q -z-4 -g -M -X -F -R -P%t?f%f:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
#export LESS="-cgiFx4M"
export PAGER=less
export GOPATH=$HOME/go
export PATH="$HOME/bin/:$HOME/.cabal/bin:$HOME/usr/bin:$PATH:$GOPATH/bin"
export PYTHONPATH=$PYTHONPATH:$HOME/lib/python3.6/site-packages:$HOME/lib/python2.7/site-packages:$HOME/lib/python2.7/dist-packages:$HOME/lib/python
export LD_LIBRARY_PATH=~/lib

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "[5~" beginning-of-history
bindkey "[6~" end-of-history
bindkey "^[[3~" delete-char
bindkey -M vicmd '^r' history-incremental-search-backward
bindkey -M viins '^r' history-incremental-search-backward

# ctrl+left and right arrow
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

if [ -f ~/.zshlocal ]; then
	. ~/.zshlocal
fi

. ~/rc/z/z.sh

echo -ne '\e%G\e[?47h\e%G\e[?47l'


