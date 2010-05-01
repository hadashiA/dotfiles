visibility=public
kind=added
names=pretty_print

--- pretty_print(pp)    -> ()

一般のオブジェクトのためのデフォルトの pretty print メソッドです。
このメソッドはインスタンス変数を列挙するために
[[m:Object#pretty_print_instance_variables]] を呼びます。

カスタマイズ(再定義)された inspect を self が持つ場合、
self.inspect の結果が使われますが、これは改行のヒントを持ちません。

もっともよく使われるいくつかの組み込みクラスについて、
PP モジュールはあらかじめ定義された pretty_print() メソッドを
簡便のために提供しています。

@param pp [[c:PP]] オブジェクトです。

