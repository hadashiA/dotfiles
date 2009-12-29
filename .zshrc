autoload -U compinit
compinit

autoload colors

export LANG=ja_JP.UTF-8

setopt auto_pushd
setopt pushd_ignore_dups
setopt print_eight_bit
setopt share_history # 同時に起動したzshの間でヒストリを共有する
setopt hist_ignore_all_dups # 同じコマンドをヒストリに残さない
setopt hist_save_nodups # ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_ignore_space # スペースから始まるコマンド行はヒストリに残さない
setopt hist_reduce_blanks # ヒストリに保存するときに余分なスペースを削除する
setopt interactive_comments # '#' 以降をコメントとして扱う
setopt magic_equal_subst # = の後はパス名として補完する
setopt auto_cd # ディレクトリ名だけでcdする

#cdpath=(${HOME} ..) # cdするときのパス。ここからの相対パスでも移動できるようになる

# prompt
setopt prompt_subst

PROMPTTTY=`tty | sed -e 's/^\/dev\///'` 
PROMPT="[%B${cyan}%~${default}%b] <%B${PROMPTTTY}%b> %E %b%# " 
if [ `whoami` = root ]; then
  RPROMPT="${red}%B%n${default}%b@${logreen}%m${default}%b" 
else 
  RPROMPT="${loyellow}%n${default}%b@${logreen}%m${default}%b" 
fi 
SPROMPT="${red}Correct ${default}> '%r' [%BY%bes %BN%bo %BA%bbort %BE%bdit] ? " 

bindkey -e
#bindkey -v

# alias
alias -g L='| less'
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'

bindkey -v

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                 /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# 補完候補をカラー表示する
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 今入力している内容から始まるヒストリを探す
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# 単語として扱う文字に / を含めない。 ^W で / の前までのディレクトリ1つ分削除できる
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
