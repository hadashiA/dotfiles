#! /bin/sh

#
# cache test
#
export USERDICT=../user-dict.sample
export REGEXDICT=../regex-dict.sample

ruby -ne 'puts $1 if /^(\w).*?	/' test-dict $USERDICT| while read line; do
     echo $line | ruby -I.. ../migemo -r $REGEXDICT -u $USERDICT test-dict\
	 > tmp.out1
     echo $line | ruby -I.. ../migemo -n -r $REGEXDICT -u $USERDICT test-dict\
	 > tmp.out2
     cmp tmp.out1 tmp.out2 || exit 1
done

for i in `ruby sample.rb ../frequent-chars`; do
    echo $i | ruby -I.. ../migemo --nocache ../migemo-dict > tmp.cache.1
    echo $i | ruby -I.. ../migemo ../migemo-dict > tmp.cache.2
    cmp tmp.cache.1 tmp.cache.2 || exit 1
done

exit 0
