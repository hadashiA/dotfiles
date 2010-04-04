kind=defined
names=parse
visibility=public

--- parse(raw_cookie)

クッキー文字列をパースします。

        例：
        cookies = CGI::Cookie.parse("raw_cookie_string")
          # { "name1" => cookie1, "name2" => cookie2, ... }

