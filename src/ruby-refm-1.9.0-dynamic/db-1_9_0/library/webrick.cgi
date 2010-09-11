methods=
sublibraries=
requires=webrick.httpstatus,webrick.httprequest,webrick.log,webrick.config,webrick.htmlutils,webrick.cookie,webrick.httpresponse,webrick.httputils,webrick.httpversion,webrick.utils,webrick.version
classes=WEBrick=CGI,WEBrick=CGI=CGIError,WEBrick=CGI=Socket
is_sublibrary=true

一般の CGI 環境で WEBrick のサーブレットと同じように CGI スクリプトを書くための
クラス。サーバが WEBrick でなくても使うことが出来る。

[[lib:webrick]]

[[c:WEBrick::HTTPServlet::AbstractServlet]] と同じようにメソッド do_GET や
do_POST を再定義することによって CGI スクリプトを書く。

普通は WEBrick::CGI のサブクラスを定義して、そのクラスに対してメソッド do_XXX を
定義する。

 #!/usr/local/bin/ruby
 require 'webrick/cgi'

 class MyCGI < WEBrick::CGI
   def do_GET(req, res)
     res["content-type"] = "text/plain"
     ret = "hoge\n"
     res.body = ret
   end
 end

 MyCGI.new.start()
