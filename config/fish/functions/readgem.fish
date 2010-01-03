function readgem --description 'open to a gems directory'
    set -l path (dirname (gem which $argv))
    echo $path
    open -a MacVim $path
end
