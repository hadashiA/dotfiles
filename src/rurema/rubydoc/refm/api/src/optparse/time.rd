require optparse

[[m:OptionParser#on]] �ǻ��Ѳ�ǽ�ʥ��饹�� [[c:Time]] ��
�ɲä���ޤ���
���ץ����ΰ����� [[c:Time]] ���饹�Υ��󥹥��󥹤��Ѵ�����Ƥ��顢
[[m:OptionParser#on]] �Υ֥��å����Ϥ���ޤ���

 require 'optparse/uri'
 opts = OptionParser.new
 
 opts.on("-t TIME", Time){|t|
   p t #=> Sat, Jan 01 2000 00:00:00 +0900
 }
 
 # ruby command -t '2000/01/01 00:00'