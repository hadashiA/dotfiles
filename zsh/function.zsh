# snatch stdout of existing process
# see http://subtech.g.hatena.ne.jp/cho45/20091118/1258554176
function snatch() {
    gdb -p $1 -batch -n -x \
        =(echo "p (int)open(\"/proc/$$/fd/1\", 1)
                p (int)dup2(\$1, 1)
                p (int)dup2(\$1, 2)")
}

# Go up
# see http://subtech.g.hatena.ne.jp/secondlife/20080604/1212562182
function gu () {
    if [[ -z "$1" ]]; then
        # move to repository root
        { [[ -n "$vcs" ]] && $0 "$.vcs" } ||
        $0 Makefile || $0 Rakefile || cd ..
        return
    fi
    local parent; parent='.'
    local fname; fname="$1"
    while [[ "${parent:a}" != "/" ]]; do
        parent="$parent/.."
        [[ -e "$parent/$fname" ]] && cd "$parent" && return
    done
    return 1
}

function watchdir () {
    if [[ "$1" != "" ]]; then
        local dir="$1"; shift
        if [[ -x "`which inotifywait`" ]]; then
            ls $dir
            while true; do
                inotifywait -q $@ $dir
            done
        else
            echo 'inotifywait not found'
        fi
    else
        echo "Usage: $0 <dir> [-e event1 -e event2 ...]"
    fi
}

# git-hg compatibility
# function git() {
#     if [[ "$vcs" = 'hg' ]]; then
#         local args; args=`git2hg $@`
#         hg ${=args}
#     else
#         env git $@
#     fi
# }

function git-set-remote () {
    if [[ "$1" == '-h'  || "$1" == '--help' || "$1" == 'help' ]]; then
        echo "Usage: $0 branch remote"
        return
    fi
    local branch=$1
    local remote=$2
    [[ -z "$brach" ]] &&  branch=master
    [[ -z "$remote" ]] && remote=origin
    git config --add branch.$branch.remote $remote
    git config --add branch.$branch.merge refs/heads/$brach
}

# 圧縮ファイル解凍
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1        ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# # CPU 使用率の高い方から5つ
# function pst() {
#   ps aux | head -n 1
#   ps aux | sort -r -n -k 3 | grep -v "ps aux" | grep -v 'grep' | head -n 5
# }

# # メモリ占有率の高い方から8つ
# function psm() {
#   ps aux | head -n 1
#   ps aux | sort -r -n -k 4 | grep -v "ps aux" | grep -v grep | head -n 5
# }

# 全プロセスから引数の文字列を含むものを grep
# function pgrep() {
#   ps aux | head -n 1
#   ps aux | grep $* | grep -v "ps aux" | grep -v grep
# }

pbcopy-buffer() { 
    print -rn $BUFFER | pbcopy
    zle -M "pbcopy: ${BUFFER}" 
}


# my function
zle -N pbcopy-buffer
bindkey '^x^p' pbcopy-buffer

