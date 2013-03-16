# Python virtualenv
# export WORKON_HOME="$HOME/.python"
# export PIP_DOWNLOAD_CACHE="$HOME/.pip_cache"
# if [[ -s "/usr/local/bin/virtualenvwrapper.sh" ]]; then
#     source "/usr/local/bin/virtualenvwrapper.sh";
#     export PIP_REQUIRE_VIRTUALENV=true
#     export PIP_RESPECT_VIRTUALENV=true
# fi
source ~/.aliases
source ~/.gitrc
source ~/.zsh/common.zsh
source ~/.zsh/local.zsh
if [[ -f $HOME/.paperboy ]]; then
    source $HOME/.paperboy
fi
