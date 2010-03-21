methods=Module/i.infect_with_assertions.minitest.spec,Object/i.must_be_empty.minitest.spec,Object/i.must_equal.minitest.spec,Object/i.must_be_close_to.minitest.spec,Object/i.must_be_within_epsilon.minitest.spec,Object/i.must_include.minitest.spec,Object/i.must_be_instance_of.minitest.spec,Object/i.must_be_kind_of.minitest.spec,Object/i.must_match.minitest.spec,Object/i.must_be_nil.minitest.spec,Object/i.must_be.minitest.spec,Object/i.must_raise.minitest.spec,Object/i.must_respond_to.minitest.spec,Object/i.must_be_same_as.minitest.spec,Object/i.must_send.minitest.spec,Object/i.must_throw.minitest.spec,Object/i.wont_be_empty.minitest.spec,Object/i.wont_equal.minitest.spec,Object/i.wont_be_close_to.minitest.spec,Object/i.wont_be_within_epsilon.minitest.spec,Object/i.wont_include.minitest.spec,Object/i.wont_be_instance_of.minitest.spec,Object/i.wont_be_kind_of.minitest.spec,Object/i.wont_match.minitest.spec,Object/i.wont_be_nil.minitest.spec,Object/i.wont_be.minitest.spec,Object/i.wont_respond_to.minitest.spec,Object/i.wont_be_same_as.minitest.spec,Kernel/i.describe.minitest.spec
sublibraries=
requires=
classes=MiniTest=Unit=TestCase,MiniTest=Spec
is_sublibrary=false

BDD 風にテストを書くためのクラスやメソッドを定義するためのライブラリです。

このライブラリは [[c:Object]] に BDD 用の検査メソッドが追加します。
追加されるメソッドは [[c:MiniTest::Assertions]] に定義されているメソッドへの
薄いラッパーになっています。
