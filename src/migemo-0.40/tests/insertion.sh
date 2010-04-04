#! /bin/sh

#
# insertion test
#
echo "mot"| ruby -I.. ../migemo -temacs -i"\\s *" -n test-dict > tmp.out
cat <<'EOF' > tmp.right
m\s *o\s *t\|ｍ\s *ｏ\s *ｔ\|も\s *[たちっつてと]\|モ\s *\([タチッツテト]\|ー\s *\(シ\s *ョ\s *ン\|タ\s *ー\)\|ス\s *ラ\)
EOF
cmp tmp.right tmp.out || exit 1

echo "mot"| ruby -I.. ../migemo -i"\\s *" -n test-dict > tmp.out
cat <<'EOF' > tmp.right
m\s *o\s *t|ｍ\s *ｏ\s *ｔ|も\s *[たちっつてと]|モ\s *(?:[タチッツテト]|ー\s *(?:シ\s *ョ\s *ン|タ\s *ー)|ス\s *ラ)
EOF
cmp tmp.right tmp.out || exit 1

exit 0
