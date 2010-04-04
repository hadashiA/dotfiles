=begin
index:Ej

= Ruby/Romkan: a Romaji <-> Kana conversion library for Ruby

Last Modified: 2002-02-12

--

Ruby/Romkan is a Romaji <-> Kana conversion library for
Ruby. It can convert a Japanese Romaji string to a Japanese
Kana string or vice versa.

Tha latest version of Ruby/Romkan is available at
((<URL:http://namazu.org/~satoru/ruby-romkan/>))
.

== Charcode

Set Ruby's charcode to EUC-JP. $KCODE="e"

== API

--- String#to_kana
    Convert a Kunrei or Hepburn Romaji string into a Kana string.

--- String#to_roma
    Conver a Hiragana string into a Hepburn Romaji string.

--- String#to_hepburn
    Convert a Kunrei Romaji string into a Hepburn Romaji string.

--- String#to_kunrei
    Convert a Hepburn Romaji string into a Kunrei Romaji string.

--- String#to_kana!
    Destructive version of String#to_kana.

--- String#to_roma!
    Destructive version of String#to_roma.

--- String#to_hepburn!
    Destructive version of String#to_hepburn.

--- String#to_kunrei!
    Destructive version of String#to_kunrei.

--- String#consonant?
    Return true if self is a consonant.

--- String#vowel?
    Return true if self is a vowel.

--- String#expand_consonant
    Expand the trailing consonant into consonants.
    e.g. "z".expand_consonant => ["za", "ze", "zi", "zo", "zu"]

== Example

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

== Download

Ruby/Romkan is a free software with ABSOLUTELY NO WARRANTY under the terms of
the Ruby's licence.

  * ((<URL:http://namazu.org/~satoru/ruby-romkan/ruby-romkan-0.4.tar.gz>))
  * ((<URL:http://cvs.namazu.org/ruby-romkan/>))

--

satoru@namazu.org
=end
