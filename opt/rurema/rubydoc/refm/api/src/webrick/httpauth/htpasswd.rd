require webrick/httpauth/userdb
require webrick/httpauth/basicauth
#@#require tempfile

= class WEBrick::HTTPAuth::Htpasswd < Object
include WEBrick::HTTPAuth::UserDB

Apache �� htpasswd �ߴ��Υ��饹��.htpasswd �ե�����򿷤����������뤳�Ȥ����롣
htpasswd -m (MD5) �� -s (SHA) �Ǻ������줿 .htpasswd �ե�����ˤ��б����Ƥ��ޤ���


��

 require 'webrick'
 include WEBrick
 htpd = HTTPAuth::Htpasswd.new('dot.htpasswd')
 htpd.set_passwd(nil, 'username', 'supersecretpass')
 htpd.flush
 htpd2 = HTTPAuth::Htpasswd.new('dot.htpasswd')
 pass = htpd2.get_passwd(nil, 'username', false)
 p pass == 'supersecretpass'.crypt(pass[0,2])

== Class Methods

--- new(path)
#@todo
Htpasswd ���֥������Ȥ��������롣.htpasswd �ե�����Υѥ��� path ��Ϳ���롣

== Instance Methods

--- delete_passwd(realm, user)
#@todo
�桼���Υѥ���ɤ������롣realm ��̵�뤵��롣

--- each{|user, pass| ...}
#@todo
�ƥ桼���ȥѥ���ɤ˴ؤ��ƥ֥��å���ɾ�����롣

--- get_passwd(realm, user, reload_db)
#@todo
�桼���Υѥ���ɤ� crypt ���줿ʸ�����������롣reload_db �� true �ξ�硢
reload ��Ƥ�Ǥ���ѥ���ɤ�������롣realm ��̵�뤵��롣

--- flush(path=nil)
#@todo
�ե�����˽񤭹��ࡣ�ե�����̾ path ��Ϳ�������ϡ�path �˽񤭹��ࡣ

--- reload
#@todo
�ե����뤫������ɤ߹��ࡣ

--- set_passwd(realm, user, pass)
#@todo
�桼���ȥѥ���ɤ���¸���롣realm ��̵�뤵��롣