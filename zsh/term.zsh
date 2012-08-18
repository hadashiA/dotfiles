# VCS
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git 
zstyle ':vcs_info:*' max-exports 7
zstyle ':vcs_info:*' formats '%r' '%R' '%S' '%b'
zstyle ':vcs_info:*' actionformats '%r' '%R' '%S' '%b|%a'

autoload -Uz is-at-least
if is-at-least 4.3.10; then
    zstyle ':vcs_info:*'  true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' formats '%r' '%R' '%S' '%b' '%c' '%u'
    zstyle ':vcs_info:*' actionformats '%r' '%R' '%S' '%b|%a' '%c' '%u'
fi

function precmd_vcs_info () {
    STY= LANG=en_US.UTF-8 vcs_info
}

function echo_prompt () {
    local maincolor repos branch

    maincolor="green"
    if [ $UID -eq 0 ]; then
        maincolor="red"
    fi

    print ""
    print -n "%F{$maincolor}┌─(%B%T%b%F{$maincolor})──%f"

    if [[ -n "$vcs_info_msg_0_" ]]; then
        branch="$vcs_info_msg_3_"
        if [[ -n "$vcs_info_msg_5_" ]]; then # staged
            branch="%F{red}$branch%f"
        elif [[ -n "$vcs_info_msg_6_" ]]; then # unstaged
            branch="%F{yellow}$branch%f"
        else
            branch="%F{blue}$branch%f"
        fi
        print -n "%F{$maincolor}<%f%B$vcs_info_msg_0_%b%F{$maincolor}@%f$branch%F{$maincolor}>%f"
    fi

    print "%F{$maincolor}──%f"
    # print -n "%F{$maincolor}└[%F{yellow}%m%f%F{$maincolor}]%f " 
    # print -n "%F{$maincolor}└%f%F{red} →%f %B" 
    print -n "%F{$maincolor}└%f"
    if [[ -n $SSH_CONNECTION ]]; then
        print -n "%F{$maincolor}[%f%F{yellow}%m%f%F{$maincolor}]%f%F{red}→%f"
    fi
    print -n " %B"
}

function echo_rprompt () {
    local repos branch

    STY= LANG=en_US.UTF-8 vcs_info
    if [[ -n "$vcs_info_msg_0_" ]]; then
        # -Dつけて、~とかに変換
        repos=`print -nD "$vcs_info_msg_1_"`

        print -n "%F{green}[%25<..<"
        print -n "%F{yellow}%B$vcs_info_msg_2_%b%f"
        print -n "%<<%F{green}]%f"

        print -n "%F{green}[%25<..<"
        print -nD "%F{yellow}$repos%f"
        print -n "%<<%F{green}]%f"

    else
        print -nD "%F{green}[%F{yellow}%60<..<%~%<<%f%F{green}]%f"
    fi
}

# set window title of screen
function set_screen_title () { echo -ne "\ek$1\e\\" }
function { # use current directory as a title
    function precmd_screen_window_title () {
        if [[ "$SCREENTITLE" = 'auto' ]]; then
            local dir
            dir=`pwd`
            dir=`print -nD "$dir"`
            if [[ ( -n "$vcs" ) && ( "$repos" != "$dir" ) ]]; then
                # name of repository and directory
                dir="${repos:t}:${dir:t}"
            else
                # name of directory
                dir=${dir:t}
            fi
            set_screen_title "$dir"
        fi
    }
}
typeset -A SCREEN_TITLE_CMD_ARG; SCREEN_TITLE_CMD_ARG=(ssh -1 su -1 man -1)
typeset -A SCREEN_TITLE_CMD_IGNORE; SCREEN_TITLE_CMD_IGNORE=()
function { # use command name as a title
    function set_cmd_screen_title () {
        local -a cmd; cmd=(${(z)1})
        while [[ "$cmd[1]" =~ "[^\\]=" ]]; do shift cmd; done
        if [[ "$cmd[1]" == "env" ]]; then shift cmd; fi
        if [[ -n "$SCREEN_TITLE_CMD_IGNORE[$cmd[1]]" ]]; then
            return
        elif [[ -n "$SCREEN_TITLE_CMD_ARG[$cmd[1]]" ]]; then
            # argument of command
            cmd[1]=$cmd[$SCREEN_TITLE_CMD_ARG[$cmd[1]]]
        fi
        set_screen_title "$cmd[1]:t"
    }
    function preexec_screen_window_title () {
        local -a cmd; cmd=(${(z)2}) # command in a single line
        if [[ "$SCREENTITLE" = 'auto' ]]; then
            case $cmd[1] in
                fg)
                    if (( $#cmd == 1 )); then
                        cmd=(builtin jobs -l %+)
                    else
                        cmd=(builtin jobs -l $cmd[2])
                    fi
                    ;;
                %*)
                    cmd=(builtin jobs -l $cmd[1])
                    ;;
                *)
                    set_cmd_screen_title "$cmd"
                    return
                    ;;
            esac
            # resolve command in jobs
            local -A jt; jt=(${(kv)jobtexts})
            $cmd >>(read num rest
                cmd=(${(z)${(e):-\$jt$num}})
                set_cmd_screen_title "$cmd"
            ) 2>/dev/null
        fi
    }
}
function title() {
    if [[ -n "$SCREENTITLE" ]]; then
        if [[ -n "$1" ]]; then
            # set title explicitly
            export SCREENTITLE=explicit
            set_screen_title "$1"
        else
            # automatically set title
            export SCREENTITLE=auto
        fi
    fi
}

# prompt
setopt prompt_subst

precmd_functions+=precmd_vcs_info

# PROMPT="%(!.%F{red}.%F{green})%U%n@%6>>%m%>>%u%f:%1(j.%j.)%(!.#.>) "
# PROMPT="%(!.%F{red}.%F{green})%U%n@%6>>%m%>>%u%f:%1(j.%j.)${WINDOW:+"[$WINDOW]"}%(!.#.>) "
PROMPT='`echo_prompt`'
RPROMPT='`echo_rprompt`'
