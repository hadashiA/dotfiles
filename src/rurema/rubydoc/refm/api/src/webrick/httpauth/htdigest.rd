require webrick/httpauth/userdb
require webrick/httpauth/digestauth
#@#require tempfile

= class WEBrick::HTTPAuth::Htdigest < Object
include WEBrick::HTTPAuth::UserDB

Apache �� htdigest �ߴ��Υ��饹��

��

 require 'webrick'
 include WEBrick
 htd = HTTPAuth::Htdigest.new('dot.htdigest')
 htd.set_passwd('realm', 'username', 'supersecretpass')
 htd.flush
 htd2 = HTTPAuth::Htdigest.new('dot.htdigest')
 p htd2.get_passwd('realm', 'username', false) == '65fe03e5b0a199462186848cc7fda42b'

== Class Methods

--- new(path)
#@todo
Htdigest ���֥������Ȥ��������롣.htdigest �ե�����Υѥ��� path ��Ϳ���롣

== Instance Methods

--- delete_passwd(realm, user)
#@todo
realm ��°����桼�� user �Υѥ���ɤ������롣

--- each{|user, realm, pass| ...}
#@todo
�ƥ桼����realm �ȥѥ���ɤ˴ؤ��ƥ֥��å���ɾ�����롣

--- flush(path=nil)
#@todo
�ե�����˽񤭹��ࡣ�ե�����̾ path ��Ϳ�������ϡ�path �˽񤭹��ࡣ

--- get_passwd(realm, user, reload_db)
#@todo
realm ����桼���Υѥ���ɤ� MD5 �ϥå����ͤ������ʸ����Ȥ����֤���
reload_db �� true �ξ�硢reload ��Ƥ�Ǥ���ϥå����ͤ��֤���

--- reload
#@todo
�ե����뤫������ɤ߹��ࡣ

--- set_passwd(realm, user, pass)
#@todo
realm ���б������ƥ桼�� user �ȥѥ���� pass ����¸���롣