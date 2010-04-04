#! /bin/sh

#
# emacs
#
echo mot| ruby -I.. ../migemo -temacs -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right
mot\|ｍｏｔ\|も[たちっつてと]\|モ\([タチッツテト]\|ー\(ション\|ター\)\|スラ\)
EOF
cmp tmp.right tmp.out || exit 1

exit 0
