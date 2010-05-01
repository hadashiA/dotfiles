visibility=public
kind=defined
names=escapeHTML

--- escapeHTML(string)

string 中の &"<> を実体参照にエンコードした文字列を新しく作成し返します。

        p CGI.escapeHTML("3 > 1")   #=> "3 &gt; 1"

