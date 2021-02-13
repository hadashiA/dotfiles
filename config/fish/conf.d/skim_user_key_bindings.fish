# Fisher sources all *_key_bindings.fish files in conf.d after
# initially backing up the fish_user_key_bindings function and
# restoring it after:
# function _fisher_copy_user_key_bindings
#     if functions -q fish_user_key_bindings
#         functions -c fish_user_key_bindings fish_user_key_bindings_copy
#     end
#     function fish_user_key_bindings
#         for file in $fisher_path/conf.d/*_key_bindings.fish
#             source $file >/dev/null 2>/dev/null
#         end
#         if functions -q fish_user_key_bindings_copy
#             fish_user_key_bindings_copy
#         end
#     end
# end
#
# Since other fisher plugins could utilize key bindings, we 
# cannot use the fish_user_key_bindings function directly since
# this would overwrite the function after each source action.

if functions -q skim_key_bindings
    skim_key_bindings
else if functions -q fzf_key_bindings
    fzf_key_bindings
end

set -l name (basename (status -f) .fish){_uninstall}

function $name --on-event $name
  bind --erase \ct
  bind --erase \cr
  bind --erase \ec
end
