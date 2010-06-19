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
function anything-history() {
    local tmpfile
    tmpfile=`mktemp`
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
bindkey "^R" anything-history
