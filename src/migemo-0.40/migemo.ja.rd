=begin
= Ruby/Migemo: ローマ字のまま日本語をインクリメンタル検索する Ruby用のライブラリ
Ruby/Migemo はローマ字のまま日本語をインクリメンタル検索する
ためのライブラリです。

最新版は ((<URL:http://migemo.namazu.org/>)) から入手可能で
す。

== 文字コード

Ruby の文字コードを EUC-JP に設定します。 $KCODE="e"

=== 使用例

  % cat sample.rb
  $KCODE="e"
  require 'migemo'

  dict = MigemoStaticDict.new("migemo-dict")
  dict_cache  = MigemoDictCache.new("migemo-dict" + ".cache")
  user_dict = MigemoUserDict.new("user-dict")

  while line = gets
    pattern = line.chomp
    migemo = Migemo.new(dict, pattern)
    migemo.optimization = 3
    migemo.dict_cache = dict_cache
    migemo.user_dict = user_dict
    migemo.type = "ruby"
    puts migemo.regex
  end

== API

--- MigemoStaticDict#new(filename)
    静的な辞書のオブジェクトを生成する

--- MigemoDictCache#new(filename)
    静的な辞書のキャッシュのオブジェクトを生成する

--- MigemoUserDict#new(filename)
    ユーザ辞書のオブジェクトを生成する

--- MigemoRegexDict#new(filename)
    正規表現辞書のオブジェクトを生成する

--- Migemo#new(dict, pattern)
    Migemoオブジェクトを生成する。dict には
    MigemoStaticDict オブジェクトを、pattern には検索パター
    ンを与える

--- Migemo#regex
    検索パターンを展開した正規表現の文字列を返す。

--- Migemo#type
    正規表現の種類 (emacs, ruby, perl) を設定する accessor。[ruby]

--- Migemo#dict_cache
    静的辞書のキャッシュを設定する accessor。

--- Migemo#usr_dict
    ユーザ辞書のオブジェクトを設定する accessor。

--- Migemo#regex_dict
    正規表現辞書のオブジェクトを設定する accessor。

--- Migemo#insertion
    1文字ごとに挟む文字列を設定する accessor。

--- Migemo#optimization
    正規表現のコンパクト化のレベル (0-3) を設定する accessor。[3]

satoru@namazu.org
=end
