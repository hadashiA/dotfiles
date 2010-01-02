function __gem_names
	gem list --no-versions | grep -v '*'
end

complete -x -c readgem -d 'gem name' -a "(__gem_names)"
