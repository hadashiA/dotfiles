source ~/.exports
source ~/.aliases
source ~/.gitrc
source ~/.zsh/common.zsh
source ~/.zsh/local.zsh

# Ruby rvm
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then source "$HOME/.rvm/scripts/rvm" ; fi

# Python virtualenv
export WORKON_HOME="$HOME/.python"
export PIP_DOWNLOAD_CACHE="$HOME/.pip_cache"
export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true
if [[ -s "/usr/local/bin/virtualenvwrapper.sh" ]]; then source "/usr/local/bin/virtualenvwrapper.sh"; fi
