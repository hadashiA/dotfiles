visibility=public
kind=defined
names=unescapeHTML

--- unescapeHTML(string)

string 中の実体参照のうち、&amp; &gt; &lt; &quot;
と数値指定がされているもの (&#0ffff など) だけを外します。

        p CGI.unescapeHTML("3 &gt; 1")   #=> "3 > 1"

