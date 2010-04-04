kind=added
names=ruby
visibility=public 

--- ruby(*args){ ... }

与えられた引数で Ruby インタプリタを実行します。

@param args Ruby インタプリタに与える引数を指定します。

例:
   ruby %{-pe '$_.upcase!' <README}


