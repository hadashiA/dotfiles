=begin
index:eJ

= Ruby/Romkan: ローマ字とひらがなを相互に変換する Ruby用のライブラリ

最終更新日: 2002-02-12

--

Ruby/Romkan はローマ字とひらがなを相互に変換する Ruby 用のライブラリです。ロー
マ字の文字列ををひらがなの文字列に変換、およびその反対を行うことができます。

最新版は ((<URL:http://namazu.org/~satoru/ruby-romkan/>))
から入手可能です。

== 文字コード

Ruby の文字コードを EUC-JP に設定します。 $KCODE="e"

== API

--- String#to_kana
    訓令式またはヘボン式のローマ字列をひらがなの文字列に変換する

--- String#to_roma
    ひらがなの文字列をヘボン式のローマ字列に変換する

--- String#to_hepburn
    訓令式のローマ字列をヘボン式のローマ字列に変換する

--- String#to_kunrei
    ヘボン式のローマ字列を訓令式のローマ字列に変換する

--- String#to_kana!
    破壊的な String#to_kana.

--- String#to_roma!
    破壊的な String#to_roma.

--- String#to_hepburn!
    破壊的な String#to_hepburn.

--- String#to_kunrei!
    破壊的な String#to_kunrei.

--- String#consonant?
    self が子音なら true を返す

--- String#vowel?
    self が母音なら true を返す

--- String#expand_consonant
    self の末尾の子音を展開する
    e.g. "z".expand_consonant => ["za", "ze", "zi", "zo", "zu"]
=== 使用例

  % irb
  irb(main):001:0> $KCODE="e"
  "e"
  irb(main):002:0> require 'romkan'
  true
  irb(main):003:0> "syatyou".to_kana
  "しゃちょう"
  irb(main):004:0> "しゃちょう".to_roma
  "shachou"
  irb(main):005:0> "syatyou".to_hepburn
  "shachou"

=== ダウンロード

Ruby のライセンスに従ったフリーソフトウェアとして公開します。
完全に無保証です。

  * ((<URL:http://namazu.org/~satoru/ruby-romkan/ruby-romkan-0.4.tar.gz>))
  * ((<URL:http://cvs.namazu.org/ruby-romkan/>))

--

satoru@namazu.org
=end
