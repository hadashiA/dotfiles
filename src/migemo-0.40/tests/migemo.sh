#! /bin/sh

#
# ordinary cases
#
echo "" | ruby -I.. ../migemo -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right

EOF
cmp tmp.right tmp.out || exit 1

echo "k" | ruby -I.. ../migemo -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right
[kｋかきくけこっカキクケコッ機帰気]
EOF
cmp tmp.right tmp.out || exit 1

echo ki| ruby -I.. ../migemo -n -O0 test-dict > tmp.out
cat <<'EOF' > tmp.right
ki|ｋｉ|き|キ|気|機|帰|機能|帰納|帰農|機能主義|機能的|帰納的
EOF
cmp tmp.right tmp.out || exit 1

echo ki| ruby -I.. ../migemo -n -O1 test-dict > tmp.out
cat <<'EOF' > tmp.right
ki|ｋｉ|き|キ|機|帰|気
EOF
cmp tmp.right tmp.out || exit 1

echo ki| ruby -I.. ../migemo -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right
[きキ機帰気]|ki|ｋｉ
EOF
cmp tmp.right tmp.out || exit 1

echo kin| ruby -I.. ../migemo -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right
kin|ｋｉｎ|き[っなにぬねのん]|キ[ッナニヌネノン]|機能|帰[納農]
EOF
cmp tmp.right tmp.out || exit 1

echo mot| ruby -I.. ../migemo -n -O2 test-dict > tmp.out
cat <<'EOF' > tmp.right
mot|ｍｏｔ|も(?:た|ち|っ|つ|て|と)|モ(?:ー(?:ション|ター)|スラ|タ|チ|ッ|ツ|テ|ト)
EOF
cmp tmp.right tmp.out || exit 1

echo mot| ruby -I.. ../migemo -n -O3 test-dict > tmp.out
cat <<'EOF' > tmp.right
mot|ｍｏｔ|も[たちっつてと]|モ(?:[タチッツテト]|ー(?:ション|ター)|スラ)
EOF
cmp tmp.right tmp.out || exit 1

exit 0
