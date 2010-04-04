#! /bin/sh
test -z "$1" && echo "Usage ngram <N> <dictionary>" && exit 1

N=$1
dictionary=$2
ruby -Ke -nle 'print $1'" if /^(\S{$N})/" $2
