set SHELL /usr/local/bin/fish
set PATH $HOME/.cargo/bin $PATH
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

function del
  m -fr $argv
end

function extract
  set -l path $argv[(count $argv)]
    if test -f $path
      switch $path
        case '*.tar.bz2'
          tar xvjf $path
        case '*.tar.gz'
          tar xvzf $path
        case '*.bz2'
          bunzip2 $path
        case '*.rar'
          unrar x $path
        case '*.gz'
          gunzip $path
        case '*.tar'
          tar xvf $path
        case '*.tbz2'
          tar xvjf $path
        case '*.tgz'
          tar xvzf $path
        case '*.zip'
          unzip $path
        case '*.Z'
          uncompress $path
        case '*.7z'
          7z x $path
        case '*'
          echo "'$path' connot be extracted via >extract<"
    end
  end
end


function ec -d "Alias for emacsclient"
  emacsclient $argv
end

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | sk --ansi -e -x | read -l result; and git checkout "$result"
end

function fhq -d "Fuzzy-find for rhq"
  cd (rhq list | sk --ansi -i)
end

function fish_user_key_bindings
  bind --erase --key \cf
end

function g
  git status $argv;
end

function ga
  git add $argv
end

function gb
  git branch $argv
end

function gc
  git commit -v $argv; 
end

function gcm
  git commit -m $argv
end

function gco
  git checkout $argv; 
end

function gog
  git log --stat --graph $argv
end

function gog1
  git log --pretty=format:"%ad:%an/%s"
end

function k
  kubectl $argv
end

function la
  lsd -la
end

function lh
  lsd -lha $argv
end

funcsave fish_user_key_bindings

# source ~/.asdf/asdf.fish

starship init fish | source