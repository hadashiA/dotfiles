require rubygems/ext

��ĥ�饤�֥���ӥ�ɤ��뤿��Υ��饹�򰷤��饤�֥��Ǥ���

= class Gem::Ext::Builder

��ĥ�饤�֥���ӥ�ɤ��뤿��Υ��饹�Ǥ���
¾�Υӥ�������饹�Ϥ��Υ��饹��Ѿ����Ƥ��ޤ���

== Singleton Methods

--- class_name -> String
#@todo

�ӥ�����Υ��饹̾���֤��ޤ���

--- make(dest_path, results)
#@todo

Makefile ���Խ����� make, make install ��¹Ԥ��ޤ���

@param dest_path ???

@param results ��̤�����뤿�������Ǥ��������ѿ����˲�Ū���ѹ�����ޤ���

@raise Gem::InstallError Makefile ��¸�ߤ��ʤ�����ȯ�����ޤ���

@raise Gem::InstallError make �μ¹Ԥ˼��Ԥ�������ȯ�����ޤ���

--- redirector -> String
#@todo

'2>&1' �Ȥ���ʸ������֤��ޤ���

--- run(command, results)
#@todo

Ϳ����줿���ޥ�ɤ�¹Ԥ��ޤ���

@param command �¹Ԥ��륳�ޥ�ɤ�ʸ����ǻ��ꤷ�ޤ���

@param results ��̤�����뤿�������Ǥ��������ѿ����˲�Ū���ѹ�����ޤ���

@raise Gem::InstallError ���ޥ�ɤμ¹Ԥ˼��Ԥ�������ȯ�����ޤ���