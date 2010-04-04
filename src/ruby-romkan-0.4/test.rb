#
# ruby -Ke test.rb </dev/null && echo ok
#
require 'romkan'

raise unless "kanji".to_kana == "かんじ"
raise unless "kanzi".to_kana == "かんじ"
raise unless "kannji".to_kana == "かんじ"
raise unless "chie".to_kana == "ちえ"
raise unless "tie".to_kana == "ちえ"
raise unless "kyouju".to_kana == "きょうじゅ"
raise unless "syuukyou".to_kana == "しゅうきょう"
raise unless "shuukyou".to_kana == "しゅうきょう"
raise unless "saichuu".to_kana == "さいちゅう"
raise unless "saityuu".to_kana == "さいちゅう"
raise unless "cheri-".to_kana == "ちぇりー"
raise unless "tyeri-".to_kana == "ちぇりー"
raise unless "shinrai".to_kana == "しんらい"
raise unless "sinrai".to_kana == "しんらい"
raise unless "hannnou".to_kana == "はんのう"
raise unless "han'nou".to_kana == "はんのう"

raise unless "je".to_kana == "じぇ"
raise unless "e-jento".to_kana == "えーじぇんと"

raise unless "kannzi".to_hepburn == "kanji"
raise unless "tie".to_hepburn == "chie"

raise unless "kanji".to_kunrei == "kanzi"
raise unless "chie".to_kunrei == "tie"

raise unless "かんじ".to_roma == "kanji"
raise unless "ちゃう".to_roma == "chau"
raise unless "はんのう".to_roma == "han'nou"

raise unless "a".consonant? == false
raise unless "k".consonant? == true

raise unless "k".expand_consonant.sort == ["ka", "ke", "ki", "ko", "ku"]
raise unless "s".expand_consonant.sort == ["sa", "se", "si", "so", "su"]
raise unless "t".expand_consonant.sort == ["ta", "te", "ti", "to", "tu"]
raise unless "ky".expand_consonant.sort == ["kya", "kyo", "kyu"]
raise unless "kk".expand_consonant.sort == ["kka", "kke", "kki", "kko", "kku"]
raise unless "sh".expand_consonant.sort == ["sha", "shi", "sho", "shu"]
raise unless "sy".expand_consonant.sort == ["sya", "syo", "syu"]
raise unless "ch".expand_consonant.sort == ["cha", "che", "chi", "cho", "chu"]

while gets
  puts $_.to_kana
end

exit 0
