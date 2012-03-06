if [[ -d /Applications/Emacs.app/ ]]; then
    # alias emacsc='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
    alias emacsd='/Applications/Emacs.app/Contents/MacOS/Emacs --daemon'
else
    alias emacsc='emacsclient -nw'
    alias emacsd='emacs --daemon'
fi

function emacsb {
    env emacs-snapshot --batch $@
}
alias emacs-compile="emacsb -f batch-byte-compile"

function stop-emacsd() {
    if [[ -n `pgrep emacs -u $USER` ]]; then
        emacsclient -e '(progn (defun yes-or-no-p (p) t) (kill-emacs))' $@
    fi
}
function restart-emacsd() {
    stop-emacsd $@
    emacsd $@
}


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
    # tmpfile=/tmp/.azh-tmp-file
    local tmpfile
    tmpfile=`mktemp azh-tmp.XXXXXX`

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
