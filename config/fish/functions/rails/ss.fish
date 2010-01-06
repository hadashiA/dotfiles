function ss --description 'Run the script/server'
    if test -x script/start
        script/start $argv
    else   
        script/server $argv
    end
end
