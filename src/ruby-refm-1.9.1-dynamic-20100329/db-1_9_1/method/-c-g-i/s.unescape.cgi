kind=defined
names=unescape
visibility=public

--- unescape(string) -> string

string を URL デコードした文字列を新しく作成し返します。

        require "cgi"

        p CGI.unescape('%40%23%23')   #=> "@##"

        p CGI.unescape("http%3A%2F%2Fwww.example.com%2Findex.rss")
        #=> "http://www.example.com/index.rss"

