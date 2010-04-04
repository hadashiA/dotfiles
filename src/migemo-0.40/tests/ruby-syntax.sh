#! /bin/sh
for i in ../*.rb; do
    ruby -wc $i >/dev/null 2>tmp.syntax
    if test ! -z "`cat tmp.syntax`"; then
        cat tmp.syntax
	exit 1
    fi
done
