# ZDOTDIR=~/.zsh

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

# Ruby 
# if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then source "$HOME/.rvm/scripts/rvm" ; fi
eval "$(rbenv init - zsh)"
