function ss --description 'Run the script/server'
	# if test -f script/start
	# 	script/start -p 3000 $argv
	# else
	# 	script/server -p 3000 $argv
	# end

        ./script/server $argv
end
