kind=defined
names=escapeElement
visibility=public

--- escapeElement(string, *elements) -> string

elements に指定したエレメントのタグだけを実体参照に置換します。

例：
        require "cgi"

        p CGI.escapeElement('<BR><A HREF="url"></A>', "A", "IMG")
             # => "<BR>&lt;A HREF="url"&gt;&lt;/A&gt"

        p CGI.escapeElement('<BR><A HREF="url"></A>', ["A", "IMG"])
             # => "<BR>&lt;A HREF="url"&gt;&lt;/A&gt"

