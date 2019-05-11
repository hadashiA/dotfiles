set SHELL /usr/local/bin/fish
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.rbenv/bin $PATH
set PATH ~/src/google-cloud-sdk/bin $PATH
set PATH ~/src/flutter/bin $PATH
set PATH ~/Library/Android/sdk/platform-tools $PATH
set PATH ~/bin $PATH
set EDITOR /usr/bin/vim
set BROWSER "open -a Firefox"
set LANG ja_JP.UTF-8

for file in ~/.config/fish/conf.d/*.fish
    source $file
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hadashi/Downloads/google-cloud-sdk/path.fish.inc' ]; if type source > /dev/null; source '/Users/hadashi/Downloads/google-cloud-sdk/path.fish.inc'; else; . '/Users/hadashi/Downloads/google-cloud-sdk/path.fish.inc'; end; end

set GOENV_ROOT $HOME/.goenv
set PATH $GOENV_ROOT/shims $PATH

set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
end

function fish_user_key_bindings
    bind --erase --key \cf
end

funcsave fish_user_key_bindings