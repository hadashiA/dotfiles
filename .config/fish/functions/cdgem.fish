function cdgem --description 'cd to a gems directory'
    set -l path (dirname (gem which $argv))
    echo $path
    cd $path
end
