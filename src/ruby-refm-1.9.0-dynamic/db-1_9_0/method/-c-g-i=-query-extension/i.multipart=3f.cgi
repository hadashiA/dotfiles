visibility=public
kind=defined
names=multipart?

--- multipart?

�ޥ���ѡ��ȥե�����ξ���true���֤�ޤ���

       �㡧
       cgi = CGI.new
       if cgi.multipart?
         field1=cgi['field1'].read
       else
         field1=cgi['field1']
       end
