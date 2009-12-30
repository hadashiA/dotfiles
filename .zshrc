# ------------------------------------------------------------------
# set env
# ------------------------------------------------------------------
export LANG=ja_JP.UTF-8
export PATH=$PATH:~/bin:/opt/local/bin:/opt/local/sbin:/opt/local/lib/mysql5/bin:/opt/local/lib/postgresql84:bin:/usr/local/git/bin:/usr/local/mysql/bin

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

#PROMPT="%n@%m ${fg[green]}%~%(?.${reset_color}.${fg[red]})> ${reset_color}"
PROMPT="%n@%m %{$fg[green]%}%~%(?.%{$reset_color%}.%{$fg[red]%})%{$reset_color%}> "

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%1v|)"

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
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

history incremental search
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
zstyle ':completion:*:default' menu select=1

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                 /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ------------------------------------------------------------------
# key bind & alias
# ------------------------------------------------------------------
bindkey -e
#bindkey -v
setopt auto_cd # ディレクトリ名だけでcdする

setopt complete_aliases

alias -g L='| less'
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g ls='ls -G -w'
alias -g la='ls -al'
alias -g du='du -h'
alias -g df='df -h'

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

