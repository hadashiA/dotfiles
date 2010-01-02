function pst
	ps aux | head -n 1
ps aux | sort -r -n -k 3 | grep -v 'ps aux' | grep -v 'grep' | head -n 5

end
