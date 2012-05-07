# PATHをクリア
PATH=

# linux (debian)
if [ -f /etc/zsh/zshenv ]; then
    source /etc/zsh/zshenv
fi

# mac
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

source ~/.exports

# Ruby rvm
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then source "$HOME/.rvm/scripts/rvm" ; fi

# Node.js nvm
if [[ -f $HOME/.nvm/nvm.sh ]]; then source $HOME/.nvm/nvm.sh ; fi
