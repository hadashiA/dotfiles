require runit/error

���Υ饤�֥��ϡ�
RubyUnit �Ȥθߴ������󶡤��뤿��������󶡤���Ƥ��ޤ���
���줫�鿷������˥åȥƥ��Ȥ�񤯤Ȥ���
[[lib:test/unit]] �饤�֥���ȤäƤ���������


= module RUNIT::Assert

RubyUnit �Υ����������򽸤᤿�⥸�塼��Ǥ���

���Υ⥸�塼��� RubyUnit �Ȥθߴ����Τ���ˤΤ��󶡤���Ƥ��ޤ���
���줫���˥åȥƥ��Ȥ�񤯤Ȥ��� [[lib:test/unit]] ��ȤäƤ���������

== Module Functions

--- assert(condition[, message])
#@todo

condition �� Ruby �ο� (false �ޤ��� nil �ʳ�) �Ǥ��뤳�Ȥ�ɽ�����ޤ���
condition �����Ǥ��ä��餳�Υ����������ϼ��Ԥ��ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_equal(expected, actual[, message])
--- assert_equals(expected, actual[, message])
#@todo

actual == expected �Ǥ��뤳�Ȥ�ɽ�����ޤ���
actual != expected �ΤȤ��ˤ��Υ����������ϼ��Ԥ��ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_operator(obj1, op, obj2[, message])
#@todo

actual.__send__(op, expected) �����Ǥ��뤳�Ȥ�ɽ�����ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_equal_float(expected, actual, e[, message])
#@todo

��ư�������� actual �� expected �����������Ȥ�ɽ�����ޤ���
���ΤȤ���expected-e <= actual <= expected+e
�Ǥ���С��������פ�Ƚ�ꤵ��ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_same(expected, actual[, message])
#@todo

expected.equal?(actual) �����Ǥ����ɽ�����ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_send(obj, method, *args)
#@todo

obj.__send__(method, *args) �����Ǥ��뤳�Ȥ�ɽ�����ޤ���

--- assert_nil(obj[, message])
#@todo

obj �� nil �Ǥ����ɽ�����ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_not_nil(obj[, message])
#@todo

obj �� nil �ǤϤʤ���ɽ�����ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_respond_to(method, obj[, message])
#@todo

���֥������� obj �˥᥽�å� method ���������Ƥ����ɽ�����ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_kind_of(c, obj[, message])
#@todo

obj.kind_of?(c) �����Ǥ����ɽ�����ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_instance_of(c, obj[, message])
#@todo

c.instance_of?(c) �����Ǥ����ɽ�����ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_match(str, re[, message])
--- assert_matches(str, re[, message])
#@todo

re =~ str �����Ǥ����ɽ�����ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_not_match(str, re[, message])
#@todo

re =~ str �����Ǥ����ɽ�����ޤ���

message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_exception(exception[, message]) { ... }
#@todo

�֥��å���¹�����㳰 exception ��ȯ�����뤳�Ȥ�ɽ�����ޤ���
�֥��å���¹Ԥ��Ƥ��㳰 exception ��ȯ�����ʤ��ä���
���Υ����������ϼ��Ԥ��ޤ���
message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_no_exception(exceptions, ...[, message]) { ... }
#@todo

�֥��å���¹�����㳰 exceptions ��ȯ�����ʤ����Ȥ�ɽ�����ޤ���
�֥��å���¹Ԥ����Ȥ����㳰 exception ��ȯ�������
���Υ����������ϼ��Ԥ��ޤ���
message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

--- assert_fail(message)
#@todo

���Υ����������Ͼ�˼��Ԥ��ޤ���
message �ϥ������ȼ��Ի��Υ��顼��å������Ǥ���

���Υ����������ϡ��ƥ��Ȥ�ޤ��񤤤Ƥ��ʤ����ˡ�
������������뤿��˻Ȥ��ޤ���