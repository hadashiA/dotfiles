#! /bin/sh

ruby -rromkan -nle 'head = split[0]; if /^\w+$/ =~ head then puts head else roma = head.to_roma; puts roma, roma.to_kunrei end' migemo-dict |uniq> tmp.ascii.words

# Get the top 500 frequent ngrams.
for i in 1 2 3 4 5 6 7 8; do
    sh ngram.sh $i tmp.ascii.words
done | sort | uniq -c | sort -nr | head -n 500 | \
awk '{print $2}'

