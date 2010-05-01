visibility=public
kind=defined
names=escapeElement

--- escapeElement(string, *elements)

elements に指定したエレメントのタグだけを実体参照に置換します。

        例：
        p CGI.escapeElement('<BR><A HREF="url"></A>', "A", "IMG")
             # => "<BR>&lt;A HREF="url"&gt;&lt;/A&gt"

        p CGI.escapeElement('<BR><A HREF="url"></A>', ["A", "IMG"])
             # => "<BR>&lt;A HREF="url"&gt;&lt;/A&gt"

