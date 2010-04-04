#! /bin/sh

cat > tmp.convert.input <<EOF
;;
;; This is a comment line.
;;
りかい /理解/
りかいs /理解/
motion /モーション/
りくとく /六徳;人が守るべき六つの徳。「ろくとく」とも/
EOF

cat > tmp.convert.output <<EOF
;;
;; This is Migemo's dictionary generated from SKK's.
;;
;;
;; This is a comment line.
;;
motion	モーション
りかい	理解
りくとく	六徳
EOF

cat tmp.convert.input | ruby ../migemo-convert.rb > tmp.convert.tmp
cmp tmp.convert.output tmp.convert.tmp || exit 1
exit 0
