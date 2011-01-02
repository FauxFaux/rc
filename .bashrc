#export TERM=linux

# Prompt of win, now without breakage.
export PS1='\[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[31m\]\w\[\033[00m\]\$ '

# Request the terminal switches to UTF-8. Breaks pscp.
#echo -ne '\e%G\e[?47h\e%G\e[?47l'

export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias duh='du --max-depth 1 | sort -n | cut -f 2 | xargs -d'\''\n'\'' du -h --max-depth 0'

shopt -s histappend

