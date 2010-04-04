#! /bin/sh

#
# symbol handling test
#
echo "|()<>[]='\`{"| ruby -I.. ../migemo -n test-dict > tmp.out
cat <<'EOF' > tmp.right
\|\(\)\<\>\[\]\=\'\`\{|¡Ã¡Ê¡Ë¡ã¡ä¡Î¡Ï¡á¡Ç¡Æ¡Ð
EOF
cmp tmp.right tmp.out || exit 1

echo "|()<>[]='\`{"| ruby -I.. ../migemo -temacs -n test-dict > tmp.out
cat <<'EOF' > tmp.right
|()<>\[\]='`{\|¡Ã¡Ê¡Ë¡ã¡ä¡Î¡Ï¡á¡Ç¡Æ¡Ð
EOF
cmp tmp.right tmp.out || exit 1

exit 0
