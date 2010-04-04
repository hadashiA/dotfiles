#! /bin/sh

#
# regex dictionary test
#
export USERDICT=../user-dict.sample
export REGEXDICT=../regex-dict.sample

echo "m" | ruby -I.. ../migemo -r $REGEXDICT -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right
[mｍっまみむめもッマミムメモ]|\([-0-9a-zA-Z_.]+@[-0-9a-zA-Z_.]+\)
EOF
cmp tmp.right tmp.out || exit 1

echo "ur" | ruby -I.. ../migemo -r $REGEXDICT -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right
ur|ｕｒ|う[っらりるれろ]|ウ[ッラリルレロ]|\(\(http\|https\|ftp\|afs\|wais\|telnet\|ldap\|gopher\|news\|nntp\|rsync\|mailto\)://[-_.!~*'()a-zA-Z0-9;/?:@&=+$,%#]+\)
EOF
cmp tmp.right tmp.out || exit 1

echo "m" | ruby -I.. ../migemo -u $USERDICT -r $REGEXDICT -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right
[mｍっまみむめもッマミムメモ]|Message Of The Day|\([-0-9a-zA-Z_.]+@[-0-9a-zA-Z_.]+\)
EOF
cmp tmp.right tmp.out || exit 1

exit 0
