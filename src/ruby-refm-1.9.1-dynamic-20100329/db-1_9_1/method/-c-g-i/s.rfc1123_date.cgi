kind=defined
names=rfc1123_date
visibility=public

--- rfc1123_date(time) -> string

時刻 time を [[RFC:1123]] フォーマットに準拠した文字列に変換します。

例：
        require "cgi"

        CGI.rfc1123_date(Time.now)
          # => Sat, 1 Jan 2000 00:00:00 GMT

