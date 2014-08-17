# precompiled source
function () {
    local A
    A=~/.zsh/modules/auto-fu/auto-fu.zsh
    [[ -e "${A:r}.zwc" ]] && [[ "$A" -ot "${A:r}.zwc" ]] ||
    zsh -c "source $A; auto-fu-zcompile $A ${A:h}" >/dev/null 2>&1
}
source ~/.zsh/modules/auto-fu/auto-fu; auto-fu-install

# initialization and options
function zle-line-init () { auto-fu-init }
zle -N zle-line-init
zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=white
zstyle ':auto-fu:var' postdisplay ''

# afu+cancel
function afu+cancel () {
    afu-clearing-maybe
    ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur"; }
}
function bindkey-advice-before () {
    local key="$1"
    local advice="$2"
    local widget="$3"
    [[ -z "$widget" ]] && {
        local -a bind
        bind=(`bindkey -M main "$key"`)
        widget=$bind[2]
    }
    local fun="$advice"
    if [[ "$widget" != "undefined-key" ]]; then
        local code=${"$(<=(cat <<"EOT"
            function $advice-$widget () {
                zle $advice
                zle $widget
            }
            fun="$advice-$widget"
EOT
        ))"}
        eval "${${${code//\$widget/$widget}//\$key/$key}//\$advice/$advice}"
    fi
    zle -N "$fun"
    bindkey -M afu "$key" "$fun"
}
bindkey-advice-before "^G" afu+cancel
bindkey-advice-before "^[" afu+cancel
bindkey-advice-before "^J" afu+cancel afu+accept-line

# incremental completion
if [[ $ZSH_VERSION == (<5->|4.<4->|4.3.<10->)* ]]; then
    function () { # precompile
        local A
        A=~/.zsh/modules/auto-fu/auto-fu.zsh
        [[ -e "${A:r}.zwc" ]] && [[ "$A" -ot "${A:r}.zwc" ]] ||
        zsh -c "source $A; auto-fu-zcompile $A ${A:h}" >/dev/null 2>&1
    }
    source ~/.zsh/modules/auto-fu/auto-fu; auto-fu-install
    function zle-line-init () { auto-fu-init }
    zle -N zle-line-init
    zstyle ':auto-fu:highlight' completion fg=white
    zstyle ':auto-fu:var' postdisplay ''
    function afu+cancel () {
        afu-clearing-maybe
        ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur"; }
    }
    function bindkey-advice-before () {
        local key="$1"
        local advice="$2"
        local widget="$3"
        [[ -z "$widget" ]] && {
            local -a bind
            bind=(`bindkey -M main "$key"`)
            widget=$bind[2]
        }
        local fun="$advice"
        if [[ "$widget" != "undefined-key" ]]; then
            local code=${"$(<=(cat <<"EOT"
                function $advice-$widget () {
                    zle $advice
                    zle $widget
                }
                fun="$advice-$widget"
EOT
            ))"}
            eval "${${${code//\$widget/$widget}//\$key/$key}//\$advice/$advice}"
        fi
        zle -N "$fun"
        bindkey -M afu "$key" "$fun"
    }
    bindkey-advice-before "^G" afu+cancel
    bindkey-advice-before "^[" afu+cancel
    bindkey-advice-before "^J" afu+cancel afu+accept-line
fi

function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    # ↓おすすめ
    # ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        git status
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter
