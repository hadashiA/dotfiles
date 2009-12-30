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

#local GREEN=$'%{\e[1;32m%}'
#local BLUE=$'%{\e[1;34m%}'
#local DEFAULT=$'%{\e[1;m%}'

# ------------------------------------------------------------------
# prompt
# ------------------------------------------------------------------
setopt prompt_subst

PROMPT="%n@%m ${fg[green]}%~%(?.${reset_color}.${fg[red]})> ${reset_color}"

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|${fg[blue]}%1v|)${reset_color}"

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

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                 /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# 今入力している内容から始まるヒストリを探す
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
