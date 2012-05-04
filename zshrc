# Python virtualenv
# export WORKON_HOME="$HOME/.python"
# export PIP_DOWNLOAD_CACHE="$HOME/.pip_cache"
# if [[ -s "/usr/local/bin/virtualenvwrapper.sh" ]]; then
#     source "/usr/local/bin/virtualenvwrapper.sh";
#     export PIP_REQUIRE_VIRTUALENV=true
#     export PIP_RESPECT_VIRTUALENV=true
# fi
source ~/.exports
source ~/.aliases
source ~/.gitrc
source ~/.zsh/common.zsh
source ~/.zsh/local.zsh
if [[ -f $HOME/.paperboy ]]; then
    source $HOME/.paperboy
fi

# autojump
[[ -s ~/.autojump/etc/profile.d/autojump.zsh ]] && source ~/.autojump/etc/profile.d/autojump.zsh

# Ruby rvm
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then source "$HOME/.rvm/scripts/rvm" ; fi

# Node.js nvm
if [[ -f $HOME/.nvm/nvm.sh ]]; then source $HOME/.nvm/nvm.sh ; fi
