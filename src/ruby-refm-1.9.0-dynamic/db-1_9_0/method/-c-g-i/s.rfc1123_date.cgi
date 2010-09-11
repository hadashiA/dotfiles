visibility=public
kind=defined
names=rfc1123_date

--- rfc1123_date(time)

時刻 time を [[RFC:1123]] フォーマットに準拠した文字列に変換します。

        例：
        CGI.rfc1123_date(Time.now)
          # => Sat, 1 Jan 2000 00:00:00 GMT

