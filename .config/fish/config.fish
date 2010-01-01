# $PATH
set -l path_list ~/bin /opt/local/bin /opt/local/sbin /opt/local/lib/mysql5/bin/ /opt/local/lib/postgresql84/bin/ /usr/local/git/bin /usr/local/mysql/bin
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

function ssdudb
  ssh ddunit_user@75.101.157.15
end

function ssdumemcached
  ssh ddunit_user@75.101.244.44
end

function ssdu1 
  ssh ddunit_user@174.129.140.240
end

function ssdu2 
  ssh ddunit_user@174.129.185.69
end

function ssdu3 
  ssh ddunit_user@174.129.182.142
end

function ssdu4 
  ssh ddunit_user@75.101.240.26
end

function ssdu5 
  ssh ddunit_user@174.129.79.192
end

function ssdustaging
  ssh ddunit_user@staging.danceunit.com   
end
