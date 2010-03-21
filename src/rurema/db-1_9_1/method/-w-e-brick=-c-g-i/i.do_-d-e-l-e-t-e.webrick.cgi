kind=defined
names=do_DELETE,do_GET,do_HEAD,do_OPTIONS,do_POST,do_PUT
visibility=public

--- do_GET(req, res)        -> ()
--- do_HEAD(req, res)       -> ()
--- do_POST(req, res)       -> ()
--- do_PUT(req, res)        -> ()
--- do_DELETE(req, res)     -> ()
--- do_OPTIONS(req, res)    -> ()

自身の service メソッドから HTTP のリクエストに応じて
呼ばれるメソッドです。WEBrick::CGI のサブクラスはこれらのメソッドを適切に実装し
なければいけません。返り値は特に規定されていません。

クライアントが使う可能性のある RFC で定義された HTTP のメソッドはすべて実装する必要があります。
クライアントからのリクエストに使われないと分かっているメソッドは実装しなくてもかまいません。
実装されていない HTTP メソッドであった場合、自身の service メソッドが
例外を発生させます。

このメソッドが呼ばれた時点では、クライアントからのリクエストに含まれる Entity Body の読み込みは
まだ行われていません。[[m:WEBrick::HTTPRequest#query]], [[m:WEBrick::HTTPRequest#body]] などの
メソッドが読ばれた時点で読み込みが行われます。クライアントから巨大なデータが送られてくることを考慮して
ユーザはプログラミングを行うべきです。

@param req クライアントからのリクエストを表す [[c:WEBrick::HTTPRequest]] オブジェクトです。

@param res クライアントへのレスポンスを表す [[c:WEBrick::HTTPResponse]] オブジェクトです。

