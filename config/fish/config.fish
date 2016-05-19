set SHELL /usr/local/bin/fish
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.rbenv/bin $PATH
set PATH ~/bin $PATH
set EDITOR /usr/bin/vim
set BROWSER "open -a Firefox"
set RUST_SRC_PATH ~/src/rustc-1.8.0/src

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end

for file in ~/.config/fish/conf.d/*.fish
    source $file
end

set ENHANCD_FILTER peco
source ~/.config/fisherman/enhancd/fish/enhancd.fish
