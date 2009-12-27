# $PATH
set -l path_list ~/bin /opt/local/bin /opt/local/lib/mysql5/bin/ /opt/local/lib/postgresql84/bin/
for i in $path_list
	if not contains $i $PATH
		if test -d $i
			set PATH $PATH $i
		end
	end
end

# $EDITOR
set EDITOR /usr/bin/vim

# $BROWSER
set BROWSER "open -a /Application/Firefox.app"

# $DEVDIR
set DEVDIR "~/dev/"

# autotest
set RSPEC true

# 
# set ARCHFLAGS '-arch x86'

# PostgreSQL
set POSTGRES_INCLUDE /opt/local/include/postgresql84/
set POSTGRES_LIB /opt/local/lib/postgresql84/

# alias
function lhome -d "cd ~/lib/home (git managiment home under files)"
  cd ~/lib/home
end
