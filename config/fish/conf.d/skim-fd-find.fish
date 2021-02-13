if type -q sk; and type -q fd
    if not set -q SKIM_DEFAULT_COMMAND
        set -x SKIM_DEFAULT_COMMAND 'fd --type f'
    end
    if not set -q SKIM_ALT_C_COMMAND # allow user override via set -Ux
        set -x SKIM_ALT_C_COMMAND 'fd -L -t d -E /sys -E /proc -E /dev -E /tmp'
    end
    if not set -q SKIM_CTRL_T_COMMAND
        set -x SKIM_CTRL_T_COMMAND 'fd -L -t f -t d -t l -E /sys -E /proc -E /dev -E /tmp'
    end
end