function sdu --description "ssh - any danceunit server"
    switch $argv[(count $argv)]
      case 's'  # staging server
        set -l hostname 'staging.danceunit.com'
      case 'd'  # db server
        set -l hostname '75.101.157.15'
      case 'm'  # memcached server
        set -l hostname '75.101.244.44'
      case '1'
        set -l hostname '174.129.140.240'
      case '2'
        set -l hostname '174.129.185.69'
      case '3'
        set -l hostname '174.129.182.142'
      case '4'
        set -l hostname '75.101.240.26'
      case '5'
        set -l hostname '174.129.79.192'
    end
end
