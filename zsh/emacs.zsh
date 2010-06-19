# alias emacsclient='emacsclient.emacs-snapshot'
alias emacsc='emacsclient -nw'
# alias emacsd='emacs-snapshot --daemon'
# alias emacs22='env emacs22'
# alias emacs23='env emacs-snapshot'
# alias emacs-standalone='emacs23'

function emacsb {
    env emacs-snapshot --batch $@
}
alias emacs-compile="emacsb -f batch-byte-compile"

# See: http://d.hatena.ne.jp/rubikitch/20091208/anythingzsh

# anything-history ()  {
#     tmpfile=/tmp/.azh-tmp-file
#     # local tmpfile
#     # tmpfile=`mktemp temp.XXXXXX`
#     emacsclient --eval '(anything-zsh-history-from-zle)' > /dev/null
#     zle -U "`cat $tmpfile`"
#     rm $tmpfile
# }

function anything-history() {
    local tmpfile
    tmpfile=`mktemp temp.XXXXXX`
    emacsclient -nw --eval \
        "(anything-zsh-history-from-zle \"$tmpfile\" \"$BUFFER\")"
    if [[ -n "$STY" ]]; then
        # screen 4.0.3 has a bug that altscreen doesn't work for emacs
        (( `screen -v | cut -f 3 -d ' ' | cut -f 2 -d.` < 1 )) && zle -I
    fi
    zle -R -c
    if [[ -n "$ANYTHING_HISTORY_DONT_EXEC" ]]; then
        zle -U "`cat $tmpfile`"
    else
        BUFFER="`cat $tmpfile`"
        [[ -n "$BUFFER" ]] && zle accept-line
    fi
    rm $tmpfile
}
zle -N anything-history
bindkey '^R' anything-history
bindkey -M afu >/dev/null 2>&1 && bindkey -M afu '^R' anything-history

# export ANYTHING_HISTORY_DONT_EXEC=1