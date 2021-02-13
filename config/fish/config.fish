set SHELL /usr/local/bin/fish
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.rbenv/bin $PATH
set PATH /opt/homebrew/bin $PATH
set PATH ~/src/google-cloud-sdk/bin $PATH
set PATH ~/src/flutter/bin $PATH
set PATH ~/Library/Android/sdk/platform-tools $PATH
set PATH ~/.dotnet/tools $PATH
set PATH ~/.n/bin $PATH
set PATH ~/bin $PATH

# set EDITOR ~/src/emacs/lib-src/emacsclient
set -x BROWSER "open -a Firefox"
set -x LANG ja_JP.UTF-8
set -x GHQ_ROOT ~/src
set -x N_PREFIX ~/.n

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
set -x FZF_DEFAULT_OPTS '-e -x +c'
set -x FZF_COMPLETION_OPTS '-e -x +c'

function ec -d "Alias for emacsclient"
  emacsclient $argv
end

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | sk --ansi -e -x | read -l result; and git checkout "$result"
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e -x +c | awk '{print $1;}' | read -l result; and git checkout "$result"
end

function fhq -d "Fuzzy-find for ghq"
  # ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 (ghq root)/{}/README*"
  ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 (ghq root)/{}/README*"
end

function fish_user_key_bindings
    bind --erase --key \cf
end

funcsave fish_user_key_bindings


# Load rbenv automatically by appending
# the following to ~/.config/fish/config.fish:

# status --is-interactive; and rbenv init - | source
