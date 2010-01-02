# http://www.dna.bio.keio.ac.jp/~yuji/zsh/zshrc.txt
#
# ------------------------------------------------------------------
# includes
# ------------------------------------------------------------------
source ~/.exports
source ~/.aliases
source ~/.gitrc

# ------------------------------------------------------------------
# callbacks
# ------------------------------------------------------------------
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd() {
    # ターミナルのウィンドウ・タイトルを動的に変更.3 -- screen 対応版
    [[ -t 1 ]] || return
    case $TERM in
        *xterm*|rxvt|(dt|k|E)term)
            #print -Pn "\e]2;%n%%${ZSH_NAME}@%m:%~ [%l]\a"
            #print -Pn "\e]2;[%n@%m %~] [%l]\a"
            print -Pn "\e]2;[%n@%m %~]\a"      # %l ← pts/1 等の表示を削除
            ;;
        # screen)
        #      #print -Pn "\e]0;[%n@%m %~] [%l]\a"
        #      print -Pn "\e]0;[%n@%m %~]\a"
        #      ;;
    esac

    # バージョン管理システムの情報取得 (%1)
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# ------------------------------------------------------------------
# colors
# ------------------------------------------------------------------
autoload colors; colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # 補完候補をカラー表示する

# ------------------------------------------------------------------
# prompt
# ------------------------------------------------------------------
## <エスケープシーケンス>
## prompt_bang が有効な場合、!=現在の履歴イベント番号, !!='!' (リテラル)
# ${WINDOW:+"[$WINDOW]"} = screen 実行時にスクリーン番号を表示 (prompt_subst が必要)
# %B = underline
# %/ or %d = ディレクトリ (0=全て, -1=前方からの数)
# %~ = ディレクトリ
# %h or %! = 現在の履歴イベント番号
# %L = 現在の $SHLVL の値
# %M = マシンのフルホスト名
#  %m = ホスト名の最初の `.' までの部分
# %S (%s) = 突出モードの開始 (終了)
# %U (%u) = 下線モードの開始 (終了)
# %B (%b) = 太字モードの開始 (終了)
# %t or %@ = 12 時間制, am/pm 形式での現在時刻
# %n or $USERNAME = ユーザー ($USERNAME は環境変数なので setopt prompt_subst が必要)
# %N = シェル名
# %i = %N によって与えられるスクリプト, ソース, シェル関数で, 現在実行されている行の番号 (debug用)
# %T = 24 時間制での現在時刻
# %* = 24 時間制での現在時刻, 秒付き
# %w = `曜日-日' の形式での日付
# %W = `月/日/年' の形式での日付
# %D = `年-月-日' の形式での日付
# %D{string} = strftime 関数を用いて整形された文字列 (man 3 strftime でフォーマット指定が分かる)
# %l = ユーザがログインしている端末から, /dev/ プレフィックスを取り除いたもの
# %y = ユーザがログインしている端末から, /dev/ プレフィックスを取り除いたもの (/dev/tty* はソノママ)
# %? = プロンプトの直前に実行されたコマンドのリターンコード
# %_ = パーサの状態
# %E = 行末までクリア
# %# = 特権付きでシェルが実行されているならば `#', そうでないならば `%' == %(!.#.%%)
# %v = psvar 配列パラメータの最初の要素の値
# %{...%} = リテラルのエスケープシーケンスとして文字列をインクルード
# %(x.true-text.false-text) = 三つ組の式
# %<string<, %>string>, %[xstring] = プロンプトの残りの部分に対する, 切り詰めの振る舞い
#         `<' の形式は文字列の左側を切り詰め, `>' の形式は文字列の右側を切り詰めます
# %c, %., %C = $PWD の後ろ側の構成要素

setopt prompt_subst

# fish like prompt
#PROMPT="%n@%m %{$fg[green]%}%~%(?.%{$reset_color%}.%{$fg[red]%})%{$reset_color%}> "
#RPROMPT="%1(v|%F%1v%f|)" # %1 はvcs_info

PROMPT="[%{$fg[blue]%}%B%~%b%{$reset_color%}] <%B%y%b> %# "
RPROMPT="%1(v|%F{blue}%1v%f|) %(!.%{$fg[red]%}.)%n%{$reset_color%}@%m"
SPROMPT="%{$fg[red]%}Correct %{$reset_color%}> '%r' [%BY%bes %BN%bo %BA%bbort %BE%bdit] ? "

# ------------------------------------------------------------------
# history
# ------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=200000
SAVEHIST=200000
setopt share_history # 同時に起動したzshの間でヒストリを共有する
setopt hist_ignore_all_dups # 同じコマンドをヒストリに残さない
setopt hist_save_nodups # ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_ignore_space # スペースから始まるコマンド行はヒストリに残さない
setopt hist_reduce_blanks # ヒストリに保存するときに余分なスペースを削除する
setopt auto_pushd
setopt pushd_ignore_dups

# 履歴検索 = C-p,n で検索・補完
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# history incremental search
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# ------------------------------------------------------------------
# completion
# ------------------------------------------------------------------
autoload -U compinit; compinit
setopt list_packed  # 補完候補を詰めて表示
setopt magic_equal_subst # = の後はパス名として補完する
setopt correct
setopt nolistbeep

autoload predict-on; predict-on

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                 /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# 補完の時に大文字小文字を区別しない (但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 一部のコマンドライン定義は、展開時に時間のかかる処理を行う -- apt-get, dpkg (Debian), rpm (Redhat), urpmi (Mandrake), perlの-Mオプション, bogofilter (zsh 4.2.1以降), fink, mac_apps (MacOS X)(zsh 4.2.2以降)
zstyle ':completion:*' use-cache true
# 補完候補を ←↓↑→ で選択 (補完候補が色分け表示される)
zstyle ':completion:*:default' menu select=1
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ------------------------------------------------------------------
# key bind & alias
# ------------------------------------------------------------------
bindkey -e
#bindkey -v
setopt auto_cd # ディレクトリ名だけでcdする

setopt complete_aliases

# ファイル名を叩くだけで実行されるコマンド
alias -s txt=cat
alias -s zip=zipinfo
alias -s tgz=gzcat
alias -s gz=gzcat
alias -s tbz=bzcat
alias -s bz2=bzcat

alias -s java=lv
alias -s c=lv
alias -s h=lv
alias -s C=lv
alias -s cpp=lv
alias -s sh=lv
alias -s txt=lv
alias -s xml=lv

alias -s html="open -a FireFox"
alias -s xhtml="open -a FireFox"

alias -s gif=display
alias -s jpg=display
alias -s jpeg=display
alias -s png=display
alias -s bmp=display

alias -s mp3=amarok
alias -s m4a=amarok
alias -s ogg=amarok

alias -s mpg=svlc
alias -s mpeg=svlc
alias -s avi=svlc
alias -s mp4v=svlc

# ------------------------------------------------------------------
# functions
# ------------------------------------------------------------------

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

# accept-line-with-url
# http://sugi.nemui.org/doc/zsh/#doc2_14
#      プロンプトにそのまま URL を打ちこんで Enter を押せば、
#      ブラウザで表示したり、ダウンロードが可能。
# 変数 WWW_BROWSER, DOWNLOADER, browse_or_download_method
browse_or_download_method="auto" # ask, auto, dwonload, browse
fpath=(~/.zsh $fpath)            # zsh function ディレクトリの設定
if autoload +X -U _accept_line_with_url > /dev/null 2>&1; then
  zle -N accept-line-with-url _accept_line_with_url
  bindkey '^M' accept-line-with-url
  #bindkey '^J' accept-line-with-url
fi

# accept-line-with-url.simple
# http://hiki.ex-machina.jp/zsh/?StartCommandWidgetized
# start() {
#     set -- ${(z)BUFFER}
#     local handler
#     if ! is_executable $1; then
#         if [[ $1 == *:* ]]; then
#             handler=$scheme_handler[${1%%:*}]
#         else
#             handler=$suffix_handler[${1##*.}]
#         fi
#         if [[ -n "$handler" ]]; then
#             BUFFER=${handler/\$1/$1}
#             zle end-of-line
#             zle set-mark-command
#             zle beginning-of-line
#             zle forward-word
#             zle quote-region
#         fi
#     fi
#     zle accept-line
# }
# autoload start
# zle -N start start
# bindkey '^M' start
# #bindkey '^J' start

# CPU 使用率の高い方から5つ
function pst() {
  ps aux | head -n 1
  ps aux | sort -r -n -k 3 | grep -v "ps aux" | grep -v 'grep' | head -n 5
}

# メモリ占有率の高い方から8つ
function psm() {
  ps aux | head -n 1
  ps aux | sort -r -n -k 4 | grep -v "ps aux" | grep -v grep | head -n 5
}

# 全プロセスから引数の文字列を含むものを grep
function pgrep() {
  ps aux | head -n 1
  ps aux | grep $* | grep -v "ps aug" | grep -v grep # grep プロセスを除外
}

# 引数の検索ワードで google 検索 (日本語可)
function google() {
  local str opt
  if [ $# != 0 ]; then # 引数が存在すれば
    for i in $*; do
      str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'` # 先頭の「+」を削除
    opt='search?num=50&hl=ja&ie=euc-jp&oe=euc-jp&lr=lang_ja'
    opt="${opt}&q=${str}"
  fi
  w3m http://www.google.co.jp/$opt # 引数がなければ $opt は空
}
alias goo=google

#-------------------------------------------------------
# function rm() {
#   if [ -d ~/.trash ]; then
#     local DATE=`date "+%y%m%d-%H%M%S"`
#     mkdir ~/.trash/$DATE
#     for i in $@; do
#       # 対象が ~/.trash/ 以下なファイルならば /bin/rm を呼び出したいな
#       if [ -e $i ]; then
#         mv $i ~/.trash/$DATE/
#       else
#         echo "$i : not found"
#       fi
#     done
#   else
#     /bin/rm $@
#   fi
# }

