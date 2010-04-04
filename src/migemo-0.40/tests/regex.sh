#! /bin/sh

#
# regular expression validation test
#
ruby sample.rb -20 ../migemo-dict |ruby -ne 'puts $1 if /(^.+?)\t/' |\
while read pattern; do
    echo $pattern |ruby -I.. ../migemo ../migemo-dict | \
	           ruby -ne 'Regexp.compile $_' || exit 1
done
exit 0
