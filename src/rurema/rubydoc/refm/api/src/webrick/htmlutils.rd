= module WEBrick::HTMLUtils

HTML �Τ���Υ桼�ƥ���ƥ��ؿ����󶡤��ޤ���

== Module Functions

--- escape(string)    -> String

���ꤵ�줿ʸ����˴ޤޤ�� ", &, <, > ��ʸ�����λ��Ȥ��Ѵ�����ʸ�����
���������֤��ޤ���

@param string ���������פ�����ʸ�������ꤷ�ޤ���

  p WEBrick::HTMLUtils.escape('/?q=foo&hl=<ja>')    #=> "/?q=foo&amp;hl=&lt;ja&gt;"