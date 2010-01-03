function pgrep
	ps aux | head -n 1
ps aux | grep $argv | grep -v 'ps aux' | grep -v 'grep'

end
