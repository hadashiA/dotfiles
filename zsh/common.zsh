# suppress suspend by C-s
stty stop undef

# remove duplicated path
typeset -gxU PATH=$PATH

# history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt no_extended_history
setopt share_history append_history
# setopt   hist_ignore_space hist_ignore_dups hist_expire_dups_first
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# options
## Changing Directories
setopt   auto_pushd pushd_to_home pushd_minus pushd_silent auto_cd
## Expansion and Globbing
setopt   extended_glob glob_dots
## Input/Output
setopt   correct rc_quotes
unsetopt correct_all
## Job Control
setopt   long_list_jobs auto_resume
unsetopt bg_nice hup
## Prompting
unsetopt prompt_cr
## Zle
unsetopt beep

# Meta-BS
bindkey -e
tcsh-backward-delete-word () {
  local WORDCHARS=
    zle backward-delete-word
}
zle -N tcsh-backward-delete-word
bindkey '^[^?' tcsh-backward-delete-word 

# completion
setopt   auto_list auto_param_slash list_packed rec_exact
unsetopt list_beep
zstyle ':completion:*' menu select
zstyle ':completion:*' format '%F{white}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' remote-access false
zstyle ':completion:*' completer _oldlist _complete _match _ignored \
    _list _history
autoload -U compinit
compinit

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# run-help
unalias  run-help 2>/dev/null || true
autoload run-help

# functions as array
typeset -ga chpwd_functions
typeset -ga precmd_functions
typeset -ga preexec_functions

# source ~/.zsh/env.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/function.zsh
source ~/.zsh/emacs.zsh
source ~/.zsh/cdd.zsh
source ~/.zsh/term.compat.zsh
source ~/.zsh/auto-fu-config.zsh
source ~/.zsh/peco-config.zsh

[[ $ZSH_VERSION == (<5->|4.<4->|4.3.<10->)* ]] && source ~/.zsh/term.zsh

fpath=(~/.zsh/modules/zsh-completions /usr/local/share/zsh/site-functions $fpath)

bindkey '^r' peco-select-history
bindkey '^@' peco-cdr
