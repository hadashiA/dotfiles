require test/unit/assertions
#@until 1.9.1
require test/unit/testsuite
#@end

#@since 1.9.1
= class Test::Unit::TestCase < MiniTest::Unit::TestCase
#@else
= class Test::Unit::TestCase < Object
#@end
include Test::Unit::Assertions
#@#include Test::Unit::Util::BacktraceFilter

�ƥ��Ȥδ���ñ��(���뤤�ϡ֥ƥ������Ρ�)��ɽ�����饹�Ǥ���
�ƥ��Ȥ�Ԥ��᥽�å�(�ƥ��ȥ᥽�å�)�� TestCase �Υ��֥��饹�Υ��󥹥��󥹥᥽�å�
�Ȥ����������ޤ����ƥ��ȥ᥽�åɤ�̾���ϡ�test�פǻϤޤäƤ��ʤ���Фʤ�ޤ���
�դˡ���test�פǻϤޤäƤ���᥽�åɤ����ƥƥ��ȥ᥽�åɤȸ��ʤ���ޤ���
#@until 1.9.1
�ƥƥ��ȥ᥽�åɤϡ�[[m:Test::Unit::TestCase.suite]] �ˤ�� [[c:Test::Unit::TestSuite]]
���֥������ȤؤȤҤȤĤˤޤȤ���ޤ���
#@end

 require 'test/unit'
#@until 1.9.1
 require 'test/unit/ui/console/testrunner'
#@end
 
 class TC_String < Test::Unit::TestCase
   def test_size
     assert_equal('abc'.size, 3)
   end

   def test_concat
     assert_raise(TypeError) do
       'abc' + 1
     end
   end
 end
 
#@until 1.9.1
 suite = TC_String.suite
 Test::Unit::UI::Console::TestRunner.run(suite)
#@end

�� TestCase ���֥������Ȥϡ��ҤȤĤΥƥ��ȥ᥽�åɤ��б����Ƥ��ޤ����ƥ��Ȥ��¹Ԥ������ˤϡ�
�ƥ��ȥ᥽�åɤο����� TestCase ���֥������Ȥ���������ޤ���

Ties everything together. If you subclass and add your own test methods, it takes care of making them into tests and wrapping those tests into a suite. It also does the nitty-gritty of actually running an individual test and collecting its results into a [[c:Test::Unit::TestResult]] object.

== Class Methods

#@since 1.9.1
--- test_order    -> Symbol

�ƥ��Ȥμ¹Խ�����֤��ޤ���

#@else
--- new(test_method_name)    -> Test::Unit::TestCase

���Υ᥽�åɤ�桼����ľ�ܸƤ֤��ȤϤ���ޤ���

test_method_name ���б����� TestCase ���֥������Ȥ����������֤��ޤ���

@param test_method_name �ƥ��ȥ᥽�åɤ�̾����ʸ�����Ϳ���ޤ���

--- suite    -> Test::Unit::TestSuite

��test�פǤϤ��ޤ륤�󥹥��󥹥᥽�å����Ƥ��Ф��ơ����줾����б�����
TestCase ���֥������Ȥ���������[[c:Test::Unit::TestSuite]] ���֥�������
�Ȥ��ƤޤȤ᤿��Τ��֤��ޤ���

��test�פǤϤ��ޤ륤�󥹥��󥹥᥽�åɤ��ʤ����ϡ�[[m:Test::Unit::TestCase#default_test]]
���б��Ť����줿 TestCase ���֥������ȤΤߤ���ġ�TestSuite ���֥������Ȥ��֤��ޤ���

== Instance Methods

--- setup    -> ()
�ƥƥ��ȥ᥽�åɤ��ƤФ������ɬ���ƤФ�ޤ���

--- teardown    -> ()
�ƥƥ��ȥ᥽�åɤ��ƤФ줿���ɬ���ƤФ�ޤ���

--- method_name    -> String

���Ȥ��б����Ƥ���ƥ��ȥ᥽�åɤ�̾����ʸ������֤��ޤ���

[[m:Test::Unit::TestCase#setup]] �� [[m:Test::Unit::TestCase#teardown]] 
�ˤ����ơ��¹Ԥ���(���뤤�ϡ��¹Ԥ���)�ƥ��ȥ᥽�åɤ�̾�����Τ�Τ�
�Ȥ����Ȥ��Ǥ��ޤ���

--- name    -> String
���Ȥ��б����Ƥ���ƥ��ȥ᥽�åɤ�̾����ʹ֤��ɤߤ䤹���������֤��ޤ���

--- run(result) {|STARTED, name| ...}

���Υ᥽�åɤ�桼����ľ�ܸƤ֤��ȤϤ���ޤ���

���Ȥ��б������ƥ��ȥ᥽�åɤ�¹Ԥ��� failures �� errors �򽸷פ��ޤ���

@param result [[c:Test::Unit::TestResult]] ���֥������Ȥ�Ϳ���ޤ���

--- size    -> Integer

��� 1 ���֤��ޤ���

--- default_test     -> ()

��˼��Ԥ���ƥ��ȤǤ���

== Private Instance Methods
--- passed?    -> bool

�ƥ��Ȥ����������ʤ顢true ���֤��ޤ��������Ǥʤ��ʤ顢false ���֤��ޤ���
[[m:Test::Unit::TestCase#teardown]] ����ǻȤ����Ȥ�տޤ���Ƥ��ޤ���
�ƥ��ȼ¹����˲����֤���������Ǥ���

== Constants

--- PASSTHROUGH_EXCEPTIONS

[[m:Test::Unit::TestCase#run]] �μ¹Ի��� rescue ����ʤ��㳰�ΰ����Ǥ���

#@include(error.rd)
#@include(failure.rd)

#@end