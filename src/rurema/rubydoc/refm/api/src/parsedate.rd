#@until 1.9.0
���դ���Ϥ��ޤ���

= module ParseDate

== Module Functions

--- parsedate(str, complete = false) -> Array | nil
str ��Ϳ����줿����ɽ������Ϥ����������������Ǥ�
���� (ǯ�����������ʬ���á������ॾ��������) ���֤��ޤ���

complete �����ǡ�ǯ�� "00" ���� "99" ���ϰϤǤ���С�
ǯ�β�2���ɽ���Ǥ���Ȥߤʤ���2����䤤�ޤ���
69 �ʾ�ʤ� 1900 ǯ��Ȥߤʤ��ޤ���
69 ̤���ʤ� 2000 ǯ��Ȥߤʤ��ޤ���

parsedate �Ϥ��������ʽ񼰤򤢤Ĥ����ޤ���
���Ȥ��С��Ĥ��Τ褦��ɽ��������Ĥ��ޤ���

  Sat
  Saturday
  1999-08-28
  21:45:09
  09:45:09 PM
  1999-08-28T21:45:09+0900
  19990828 214509
  H11.08.28T21:45:09Z
  Sat Aug 28 21:45:09 1999
  Sat Aug 28 21:45:09 JST 1999
  Sat, 28 Aug 1999 21:45:09 -0400
  Saturday, 28-Aug-99 21:45:09 GMT
  08/28/1999
  1999/08/28

���Υ饤�֥��ϡ�1.9.0 �ʹ����Ѥ��뤳�Ȥ�����ޤ���

���ղ��Ϥ�ľ���� [[c:Date]]��
���뤤�� [[c:DateTime]] ���֥������Ȥ���������ˤϡ�
[[lib:date]] ���󶡤���� [[m:Date.parse]]��
[[m:DateTime.parse]] �� [[m:Date.strptime]]��
[[m:DateTime.strptime]] �ʤɤ�Ĥ������Ȥ��Ǥ��ޤ���

���ղ��Ϥ�ľ���� [[c:Time]] ���֥������Ȥ���������ˤϡ�
[[lib:time]] ���󶡤���� [[m:Time.parse]] ��Ĥ������Ȥ��Ǥ��ޤ���

@param str ���դ򤢤�魯ʸ����
@param complete ǯ���䴰���뤫

  require 'parsedate'

  ParseDate.parsedate('Sat Aug 28 21:45:09 1999')
      # => [1999, 8, 28, 21, 45, 9, nil, 6]

  ParseDate.parsedate('Saturday, 28-Aug-99 21:45:09 GMT')
      # => [99, 8, 28, 21, 45, 9, "GMT", 6]

  ParseDate.parsedate('99-08-28', true)
      # => [1999, 8, 28, nil, nil, nil, nil, nil]

  ParseDate.parsedate('01-08-28', true)
      # => [2001, 8, 28, nil, nil, nil, nil, nil]
#@end