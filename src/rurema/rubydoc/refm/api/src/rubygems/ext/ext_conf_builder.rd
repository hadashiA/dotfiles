require rubygems/ext/builder

extconf.rb �򸵤ˤ��Ƴ�ĥ�饤�֥���ӥ�ɤ��뤿��Υ��饹�򰷤��饤�֥��Ǥ���

= class Gem::Ext::ExtConfBuilder < Gem::Ext::Builder

extconf.rb �򸵤ˤ��Ƴ�ĥ�饤�֥���ӥ�ɤ��뤿��Υ��饹�Ǥ���

== Singleton Methods

--- build(extension, directory, dest_path, results) -> Array
#@todo

Makefile ��¸�ߤ��ʤ����ϡ�extconf.rb ��¹Ԥ���
Makefile ��������Ƥ��� make ��¹Ԥ��ޤ���

@param extension �ե�����̾����ꤷ�ޤ���

@param directory ���Υ᥽�åɤǤϻ��Ѥ��Ƥ��ޤ���

@param dest_path ???

@param results ���ޥ�ɤμ¹Է�̤��Ǽ���ޤ����˲�Ū���ѹ�����ޤ���

@see [[m:Gem::Ext::Builder.make]]