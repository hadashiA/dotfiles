kind=defined
names=[]
visibility=public

--- [](key)

文字列 key に対応するパラメータを配列で返します。
key に対応するパラメータが見つからなかった場合は、nil を返します。（[[m:CGI#params]]と等価です）

フォームから入力された値や、URL に埋め込まれた QUERY_STRING のパース結果の取得などに使用します。

((<ruby 1.8 feature>)): 挙動が 1.6 以前の cgi と大きく変化しています ((- この挙動は流動的で、1.8.0, 1.8.1, 1.8.2 の挙動はすべて異なります（1.9.0の挙動は1.8.2と同様です）。 -)) 。メソッドの返り値は配列でなく、文字列 ((- 1.8.1 までは、正確に言うと String ではありません。 -)) になり、それに伴って cgi[key][0] のような書き方は廃止されました。また key に対応するパラメータが存在しなかった場合、nil ではなく "" を返すようになっています。 ruby 1.6 と同じ挙動を望む場合は、[[m:CGI#params]]を利用してください。

この結果、インターフェースがどう変わったのかについては、以下の例を参考にしてください。

      # with ruby 1.6 ---------------------------
      cgi = CGI.new
      cgi['developer']     # => ["Matz"] (Array)
      cgi['developer'][0]  # => "Matz" (String)
      cgi['']              # => nil

      # with ruby 1.8 ---------------------------
      cgi = CGI.new
      cgi['developer']     # => "Matz"
      cgi['developer'][0]  # => obsolete（警告が出ます）
      cgi['']              # => ""

cgi['developer'].is_a?(String) # => 1.8.1まではfalse、1.8.2以降はtrue

    [[unknown:執筆者募集]]

