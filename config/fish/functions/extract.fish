function extract
    set -l path $argv[(count $argv)]
	  if test -f $path
        switch $path
            case '*.tar.bz2'
                tar xvjf $path
            case '*.tar.gz'
                tar xvzf $path
            case '*.bz2'
                bunzip2 $path
            case '*.rar'
                unrar x $path
            case '*.gz'
                gunzip $path
            case '*.tar'
                tar xvf $path
            case '*.tbz2'
                tar xvjf $path
            case '*.tgz'
                tar xvzf $path
            case '*.zip'
                unzip $path
            case '*.Z'
                uncompress $path
            case '*.7z'
                7z x $path
            case '*'
                echo "'$path' connot be extracted via >extract<"
        end
    end
end
