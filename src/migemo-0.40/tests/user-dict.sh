#! /bin/sh

#
# user dictionary test
#
export USERDICT=../user-dict.sample
export REGEXDICT=../regex-dict.sample

echo "mot" | ruby -I.. ../migemo -u $USERDICT -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right
mot|ｍｏｔ|も[たちっつてと]|モ(?:[タチッツテト]|ー(?:ション|ター)|スラ)|Message Of The Day
EOF
cmp tmp.right tmp.out || exit 1

echo "c" | ruby -I.. ../migemo -u $USERDICT -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right
[cｃちっチッ]|Sony CSL|ソニー(?:CSL|コンピュータサイエンス研究所)
EOF
cmp tmp.right tmp.out || exit 1

echo "nais" | ruby -I.. ../migemo -u $USERDICT -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right
nais|ｎａｉｓ|ない[さしすせそっ]|ナイ[サシスセソッ]|奈良先端(?:大|科学技術大学院大学)
EOF
cmp tmp.right tmp.out || exit 1

exit 0
