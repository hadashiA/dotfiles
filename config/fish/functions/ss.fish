function ss --description 'Run the script/server'
	if test -f script/start
		script/start -p 6020 $argv
	else
		script/server -p 6020 $argv
	end


end
