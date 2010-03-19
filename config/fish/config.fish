# $PATH
# set -l path_list $HOME/bin /opt/local/bin /opt/local/sbin /opt/local/lib/mysql5/bin/ /opt/local/lib/postgresql84/bin/ /usr/local/git/bin /usr/local/mysql/bin
# for i in $path_list
#     if not contains $i $PATH
#         if test -d $i
#            echo $PATH
#            set PATH $PATH $i
# 	end
#     end
# end

set PATH ~/bin $PATH
set PATH /usr/local/git/bin/ $PATH
set PATH /usr/local/mysql/bin/ $PATH
set PATH /opt/local/bin $PATH
set PATH /opt/local/sbin $PATH
set PATH /opt/local/lib/postgresql84/bin $PATH

set ARCHFLAGS='-arch x86'
set RSPEC=true

# PostgreSQL
# set POSTGRES_INCLUDE=/opt/local/include/postgresql84/
# set POSTGRES_LIB=/opt/local/lib/postgresql84/


set EDITOR /usr/bin/vim
set BROWSER "open -a Firefox"
set RSPEC true
#set ARCHFLAGS '-arch x86_64'

# PostgreSQL
set POSTGRES_INCLUDE /opt/local/include/postgresql84/
set POSTGRES_LIB /opt/local/lib/postgresql84/

# set function sub directory
#set fish_function_path $fish_function_path ~/.config/fish/functions/override
#set fish_function_path $fish_function_path ~/.config/fish/functions/git
#set fish_function_path $fish_function_path ~/.config/fish/functions/rails
