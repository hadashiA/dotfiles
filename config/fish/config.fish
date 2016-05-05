set PATH ~/bin $PATH
set PATH /opt/local/bin $PATH
set PATH /opt/local/sbin $PATH

set ARCHFLAGS='-arch x86'
set LANGUAGE=ja

set EDITOR /usr/bin/vim
set BROWSER "open -a Firefox"
#set ARCHFLAGS '-arch x86_64'

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end
