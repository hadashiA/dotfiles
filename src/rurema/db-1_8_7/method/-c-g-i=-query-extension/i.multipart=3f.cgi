kind=defined
names=multipart?
visibility=public

--- multipart?

マルチパートフォームの場合にtrueが返ります。

       例：
       cgi = CGI.new
       if cgi.multipart?
         field1=cgi['field1'].read
       else
         field1=cgi['field1']
       end

