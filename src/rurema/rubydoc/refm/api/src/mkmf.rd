Ruby �γ�ĥ�饤�֥��Τ���� Makefile ���������饤�֥��Ǥ���

���Υ饤�֥����̾extconf.rb �Ȥ���̾���� ruby ������ץȤ��� require ����ޤ���
���� extconf.rb ��¹Ԥ��� Makefile ���������Τ������Ǥ���

extconf.rb �ν񤭤����ˤĤ��Ƥϡ�
Ruby �Υ��������֤˴ޤޤ�� README.EXT (���ܸ��Ǥ� README.EXT.ja)
�⻲�Ȥ��Ƥ���������

=== �Ȥ���

�Ͷ��γ�ĥ�饤�֥�� foo.so ��������뤳�Ȥ�ͤ��ޤ���
���γ�ĥ�饤�֥���������뤿��ˤϡ�
�إå��ե����� bar.h �ȥ饤�֥�� libbar.a �δؿ� baz() ��ɬ�פ��Ȥ��ޤ���
���Τ���� extconf.rb �ϰʲ��Τ褦�˽񤭤ޤ���

  require 'mkmf'

  dir_config('bar')
  if have_header('bar.h') and have_library('bar', 'baz')
    create_makefile('foo')
  end

��ĥ�饤�֥�� foo.so ����������󥹥ȡ��뤹��ˤϰʲ��Τ褦�ˤ��ޤ���

  $ ruby extconf.rb
  $ make
  $ make site-install

foo.so �� extconf.rb �Ǥ� dir_config('bar') ��¹Ԥ��Ƥ���Τǡ�
�桼���ϰʲ��Τ褦�˥��ޥ�ɥ饤�󥪥ץ���� --with-bar-dir
�ʤɤ�Ȥäơ��إå��ե�����Υѥ���饤�֥��Υѥ������Ǥ��ޤ���

  $ ruby extconf.rb --with-bar-include=/usr/local/include \
                    --with-bar-lib=/usr/local/lib

  �ޤ���

  $ ruby extconf.rb --with-bar-dir=/usr/local

dir_config �ؿ��ξܺ٤ˤĤ��Ƥ�
[[m:Kernel#dir_config]] �򻲾Ȥ��Ƥ���������

=== configure ���ץ����

configure ���ץ����Ȥ� Ruby ���󥿥ץ꥿�Υ���ѥ�����˻��ꤵ�줿
configure ������ץȤΥ��ץ����
�ޤ��� extconf.rb �¹Ի��Υ��ץ����Τ��ȤǤ���
extconf.rb �κ����Ԥ�Ǥ�դΥ��ץ���������Ǥ��ޤ���
[[m:Kernel#arg_config]] �⻲�Ȥ��Ƥ���������

�ޤ����ʲ��Υ��ץ���󤬥ǥե���Ȥ����Ѳ�ǽ�Ǥ���

: --with-opt-include=DIR
    �إå��ե������õ������ǥ��쥯�ȥ� DIR ���ɲä��ޤ���

: --with-opt-lib=DIR
    �饤�֥��ե������õ������ǥ��쥯�ȥ� DIR ���ɲä��ޤ���

: --with-opt-dir=DIR

    �إå��ե����롢�饤�֥��ե������õ������ǥ��쥯�ȥ�
    DIR/include��DIR/lib �򤽤줾���ɲä��ޤ���

: --with-TARGET-include=DIR

    �إå��ե������õ������ǥ��쥯�ȥ� DIR ���ɲä��ޤ���

    extconf.rb ����� dir_config(TARGET)
    ��¹Ԥ��Ƥ���Ф��Υ��ץ��������Ǥ��ޤ���

: --with-TARGET-lib=DIR

    �饤�֥���õ������ǥ��쥯�ȥ� DIR ���ɲä��ޤ���

    extconf.rb ����� dir_config(TARGET)
    ��¹Ԥ��Ƥ���Ф��Υ��ץ��������Ǥ��ޤ���

: --with-TARGET-dir=DIR

    �إå��ե����롢�饤�֥��ե������õ������ǥ��쥯�ȥ�
    DIR/include��DIR/lib �򤽤줾���ɲä��ޤ���

    extconf.rb ����� dir_config(TARGET)
    ��¹Ԥ��Ƥ���Ф��Υ��ץ��������Ǥ��ޤ���

=== depend �ե�����

�����ȥǥ��쥯�ȥ�� depend �Ȥ���̾���Υե����뤬�����硢
��������� Makefile �κǸ�� depend �ե���������Ƥ��ɲä���ޤ���

depend �ե�����ϥ������ե�����ΰ�¸�ط��򵭽Ҥ��뤿��˻Ȥ��ޤ���
�㤨�г�ĥ�饤�֥��Υ����������� foo.c �� foo.h �򥤥󥯥롼�ɤ��Ƥ����硢
foo.h ���������줿�Ȥ��ˤ� foo.c ��ƥ���ѥ��뤷�����Ǥ��礦��
���Τ褦�ʰ�¸�ط��򵭽Ҥ���ˤ� depend �ե�����˰ʲ��� 1 �Ԥ�񤭤ޤ���

  foo.o: foo.c foo.h

���Τ褦�˽񤯤ȡ�foo.o �� foo.c �� foo.h �˰�¸���Ƥ��뤳�Ȥ򼨤��ޤ���
�Ĥޤꡢfoo.c �� foo.h �Τɤ��餫���������줿����
foo.o ���ꥳ��ѥ��뤵���褦�ˤʤ�ޤ���

C ����ѥ���ˤ�äƤϡ����Τ褦�ʵ��Ҥ�ư�����Ǥ��ޤ���
���̤ˡ����Τ���Υ��ץ����ϡ�-M�פǤ���
��-M�ץ��ץ�������� C ����ѥ����ȤäƤ�����ϡ�
�ʲ��Υ��ޥ�ɤ�¹Ԥ��������Ŭ�ڤ� depend �������Ǥ��ޤ���

  $ cc -M *.c > depend

gcc �ˤϡ�-M ���ץ������������ -MM �Ȥ������ץ����⤢��ޤ���
���Υ��ץ����ϡ��̾ﹹ�����뤳�ȤΤʤ� stdio.h �ʤɡ�
�����ƥ�Υإå��ե�������¸�ط��˴ޤ�ޤ���
���� -MM ���ץ����Ǥϡ���#include <...>�פη����ǻ��Ȥ����
�إå��ե�����򥷥��ƥ�Υإå��ե�����Ȥߤʤ��Ƥ���褦�Ǥ���

gcc �� -MM ���ץ�����Ȥ����ϡ�
�ʲ��Υ��ޥ�ɤ�¹Ԥ����Ŭ�ڤ� depend �������Ǥ��ޤ���

  $ gcc -MM *.c > depend

�ʤ���depend �ե�������¸�ط��ε��Ұʳ��˻Ȥ��٤��ǤϤ���ޤ���
mkmf.rb �� depend �ե������ Makefile ��Ϣ�뤹��Ȥ��ˡ�
�������Ƥ�ù������礬���뤫��Ǥ���

=== extconf.rb ���������� make �������å�

extconf.rb ���������� Makefile �ˤϰʲ��Υ������åȤ��������Ƥ��ޤ���

: all
    ��ĥ�饤�֥���������ޤ���

: clean
    ����������ĥ�饤�֥�ꡢ���֥������ȥե�����ʤɤ������ޤ���

: distclean
: realclean
    clean �������åȤ��������ե�����˲ä��ơ�
    Makefile, extconf.h, core, ruby �ʤɤ������ޤ���

: install
: site-install
    ����������ĥ�饤�֥��� $sitearchdir �˥��󥹥ȡ��뤷�ޤ���
    �����ȥǥ��쥯�ȥ�˥ǥ��쥯�ȥ� lib �������
    �����۲��� ruby ������ץ� (*.rb �ե�����) ��
    �ǥ��쥯�ȥ곬�ؤ��ݤä��ޤ� $sitelibdir �˥��󥹥ȡ��뤷�ޤ���



= reopen Kernel

== Private Instance Methods
#@# �ʲ��ϡ�extconf.rb �򵭽Ҥ���Τ�ͭ�Ѥʴؿ��Ǥ���
#@# �إå��ե������¸�ߥ����å����饤�֥���¸�ߥ����å��ʤɡ�
#@# �����ƥ�֤κ��ۤ�Ĵ�٥����ƥ��Ŭ���� Makefile ���������뤿���
#@# �����δؿ���ɬ�פȤʤ�ޤ���

#@# --- rm_f(files...)
#@#     �ե����� ((|files|)) �������ޤ���((|files|)) �ˤ� 
#@#     ((<Dir.glob|Dir>)) �Υ磻��ɥ����ɤ���ꤹ�뤳�Ȥ��Ǥ�
#@#     �ޤ���
#@# 
#@# --- xsystem(command)
#@#     ruby ���Ȥ߹��ߴؿ� ((<system|�Ȥ߹��ߴؿ�>))() ��Ʊ���Ǥ�
#@#     �������ޥ�ɤν��Ϥ�(ɸ����ϡ�ɸ�२�顼���ϤȤ��)����
#@#     �ե�����˽��Ϥ���ޤ��������ե�����̾�� mkmf.log �Ǥ���
#@# 
#@#     ruby ��ǥХå����ץ����((({-d})))�դ��Ǽ¹Ԥ������ϡ����ޥ��
#@#     ��ɽ���������((<system|�Ȥ߹��ߴؿ�>))(((|command|))) ��¹Ԥ��ޤ���
#@# 
#@# --- try_link0(src[, opt])
#@#     ((<mkmf/try_link>)) �μ��ΤǤ���

--- try_link(src[, opt])
#@todo

C �ץ������Υ����������� src �򥳥�ѥ��롢��󥯤��ޤ���
����ʤ���󥯤Ǥ����� true ���֤��ޤ���
����ѥ���ȥ�󥯤˼��Ԥ����� false ���֤��ޤ���

�� 2 ���� opt �����ꤵ�줿�Ȥ��ϡ���󥫤˥��ޥ�ɰ����Ȥ����Ϥ��ޤ���
�ޤ������Υ᥽�åɤ� [[m:$CFLAGS]] �� [[m:$LDFLAGS]] ���ͤ�
����ѥ���ޤ��ϥ�󥫤��Ϥ��ޤ���

�㡧

  if try_link("int main() { sin(0.0); }", '-lm')
    $stderr.puts "sin() exists"
  end

--- try_cpp(src[, opt])
#@todo

C �ץ������Υ����������� src ��ץ�ץ��������ޤ���
����ʤ��ץ�ץ������Ǥ����� true ���֤��ޤ���
�ץ�ץ������˼��Ԥ����� false ���֤��ޤ���

�� 1 ���� src ��ʸ������Ϥ��ޤ���

�� 2 ���� opt �� [[m:$CFLAGS]] ���ͤ�
�ץ�ץ����å��˥��ޥ�ɥ饤������Ȥ����Ϥ��ޤ���

���Υ᥽�åɤϥإå��ե������¸�ߥ����å��ʤɤ˻��Ѥ��ޤ���

�㡧

  if try_cpp("#include <stdio.h>")
    $stderr.puts "stdio.h exists"
  end

--- egrep_cpp(pat, src[, opt])
#@todo

C �ץ������Υ����������� src ��ץ�ץ���������
���η�̤�����ɽ�� pat �˥ޥå����뤫�ɤ�����Ƚ�ꤷ�ޤ���

  CPP $CFLAGS opt | egrep pat

��¹Ԥ������η�̤����狼�ɤ����� true �ޤ��� false ���֤��ޤ���

�� 1 ���� pat �ˤϡ�egrep �Ρ�����ɽ����ʸ����ǻ��ꤷ�ޤ���
Ruby ������ɽ���ǤϤ���ޤ���

�� 2 ���� src �ˤ� C ����Υ����������ɤ�ʸ����ǵ��Ҥ��ޤ���

���Υ᥽�åɤϥإå��ե�����˴ؿ��ʤɤ���������뤫�ɤ���
�������뤿��˻��Ѥ��ޤ���

--- try_run(src[, opt])
#@todo

C �ץ������Υ����������� src �򥳥�ѥ��뤷��
�������줿�¹ԥե������¹Ԥ��ޤ���
����˼¹ԤǤ���� true ���֤��ޤ���
�¹Ԥ����Ԥ������� false ���֤��ޤ���

�� 1 ���� src �ˤ� C ����Υ����������ɤ�ʸ����ǵ��Ҥ��ޤ���

�� 2 ���� opt �ˤ� C ����ѥ���Υ��ץ�������ꤷ�ޤ���

--- install_rb(mfile, dest, srcdir = '.')
#@todo
#@# ���Υ᥽�åɤ� create_makefile �����Ѥ��ޤ�

�ǥ��쥯�ȥ� srcdir/lib �۲��� Ruby ������ץ� (*.rb �ե�����)
�� dest �˥��󥹥ȡ��뤹�뤿��� Makefile ��§�� mfile �˽��Ϥ��ޤ���
mfile �� [[c:IO]] ���饹�Υ��󥹥��󥹤Ǥ���

srcdir/lib �Υǥ��쥯�ȥ깽¤�Ϥ��Τޤ� dest �۲���ȿ�Ǥ���ޤ���

--- append_library(libs, lib)
#@todo

�饤�֥��Υꥹ�� libs ����Ƭ�˥饤�֥�� lib ���ɲä���
���η�̤��֤��ޤ���

���� libs �Ȥ��Υ᥽�åɤ�����ͤ�
��󥫤��Ϥ�����������ʸ����Ǥ���
���ʤ����UNIX �� OS �Ǥ�

  "-lfoo -lbar"

�Ǥ��ꡢMS Windows �ʤɤǤ�

  "foo.lib bar.lib"

�Ǥ���
�� 2 ���� lib �ϡ�������Ǥ� "foo" �� "bar" �ˤ�����ޤ���

--- have_macro(macro, headers = nil, opt = "", &b)
#@todo
Returns whether or not +macro+ is defined either in the common header
files or within any +headers+ you provide.

Any options you pass to +opt+ are passed along to the compiler.

--- have_library(lib[, func])
#@todo

�饤�֥�� lib �������ƥ��¸�ߤ���
�ؿ� func ���������Ƥ��뤫�ɤ���������å����ޤ���
�����å������������ [[m:$libs]] �� lib ���ɲä� true ���֤��ޤ���
�����å������Ԥ����� false ���֤��ޤ���

�� 2 ���� func ���ά������硢�ؿ���¸�ߤޤǤϸ���������
�饤�֥�꤬¸�ߤ��뤫�ɤ�������������å����ޤ���

�� 2 ���� func �� nil �ޤ��϶�ʸ���� ("") �ΤȤ��ϡ�
���⸡���򤻤���̵���� lib ���ɲä��ޤ���

--- find_library(lib, func, *pathes)
#@todo

�ؿ� func ��������줿�饤�֥�� lib ��õ���ޤ���
�ǽ�ϥѥ�����ꤻ����õ����
����˼��Ԥ����� pathes[0] ����ꤷ��õ����
����ˤ⼺�Ԥ����� pathes[1] ����ꤷ��õ���ġ�
�Ȥ����褦�ˡ���󥯲�ǽ�ʥ饤�֥���õ�����ޤ���

�嵭��õ���ǥ饤�֥�� lib ��ȯ���Ǥ������� lib �� [[m:$libs]] ���ɲä���
���Ĥ��ä��ѥ��� [[m:$LDFLAGS]] ���ɲä��� true ���֤��ޤ���
���ꤵ�줿���٤ƤΥѥ��򸡺����Ƥ�饤�֥�� lib �����Ĥ���ʤ��Ȥ��ϡ�
�ѿ����ѹ����� false ���֤��ޤ���

pathes ����ꤷ�ʤ��Ȥ��� [[m:Kernel#have_library]] ��Ʊ��ư��Ǥ���

--- find_header(header, *paths)
#@todo
Instructs mkmf to search for the given +header+ in any of the +paths+
provided, and returns whether or not it was found in those paths.

If the header is found then the path it was found on is added to the list
of included directories that are sent to the compiler (via the -I switch).

--- have_func(func[, header])
#@todo

�ؿ� func �������ƥ��¸�ߤ��뤫�ɤ����򸡺����ޤ���

�ؿ� func ��¸�ߤ���� [[m:$defs]] ��
"-DHAVE_func" (func ����ʸ�����Ѵ�����ޤ�) ���ɲä��� true ���֤��ޤ���
�ؿ� func �����Ĥ���ʤ��Ȥ��ϥ������Х��ѿ����ѹ����� false ���֤��ޤ���

�� 2 ���� header �ˤϡ�
�ؿ� func ����Ѥ���Τ�ɬ�פʥإå��ե�����̾����ꤷ�ޤ���
����ϴؿ��η�������å����뤿��ǤϤʤ���
�ؿ����ºݤˤϥޥ������������Ƥ�����ʤɤΤ���˻��Ѥ��ޤ���

--- have_header(header)
#@todo

�إå��ե����� header �������ƥ��¸�ߤ��뤫�ɤ���Ĵ�٤ޤ���

�إå��ե����� header ��¸�ߤ����
�������Х��ѿ� [[m:$defs]] �� "-DHAVE_header" ���ɲä��� true ���֤��ޤ���
�إå��ե����� header ��¸�ߤ��ʤ��Ȥ��� $defs ���ѹ����� false ���֤��ޤ���
�ʤ���-DHAVE_header �� header �ˤϡ�
�ºݤˤ� header.upcase.tr('-.', '_') ���Ȥ��ޤ���

--- have_struct_member(type, member, headers = nil, &b)
#@todo

Returns whether or not the struct of type +type+ contains +member+.  If
it does not, or the struct type can't be found, then false is returned.  You
may optionally specify additional +headers+ in which to look for the struct
(in addition to the common header files).

If found, a macro is passed as a preprocessor constant to the compiler using
the member name, in uppercase, prepended with 'HAVE_ST_'.

For example, if have_struct_member('foo', 'bar') returned true, then the
HAVE_ST_BAR preprocessor macro would be passed to the compiler.
 

--- have_type(type, headers = nil, opt = "", &b)
#@todo
Returns whether or not the static type +type+ is defined.  You may
optionally pass additional +headers+ to check against in addition to the
common header files.

You may also pass additional flags to +opt+ which are then passed along to
the compiler.

If found, a macro is passed as a preprocessor constant to the compiler using
the type name, in uppercase, prepended with 'HAVE_TYPE_'.

For example, if have_type('foo') returned true, then the HAVE_TYPE_FOO
preprocessor macro would be passed to the compiler.

--- have_var(var, headers = nil, &b)
#@todo
Returns whether or not the variable +var+ can be found in the common
header files, or within any +headers+ that you provide.  If found, a
macro is passed as a preprocessor constant to the compiler using the
variable name, in uppercase, prepended with 'HAVE_'.

For example, if have_var('foo') returned true, then the HAVE_FOO
preprocessor macro would be passed to the compiler.

--- check_sizeof(type, headers = nil, &b)
#@todo
Returns the size of the given +type+.  You may optionally specify additional
+headers+ to search in for the +type+.

If found, a macro is passed as a preprocessor constant to the compiler using
the type name, in uppercase, prepended with 'SIZEOF_', followed by the type
name, followed by '=X' where 'X' is the actual size.

For example, if check_sizeof('mystruct') returned 12, then the
SIZEOF_MYSTRUCT=12 preprocessor macro would be passed to the compiler.

--- arg_config(config[, default])
#@todo

configure ���ץ���� --config ���ͤ��֤��ޤ���
���ץ���󤬻��ꤵ��Ƥ��ʤ��Ȥ����� 2 ���� default ���֤��ޤ���

�㤨�� extconf.rb �� arg_config �᥽�åɤ�Ȥ���硢

  $ ruby extconf.rb --foo --bar=baz

�ȼ¹Ԥ����Ȥ���arg_config("--foo") ���ͤ� true��
arg_config("--bar") ���ͤ� "baz" �Ǥ���

--- with_config(config[, default])
#@todo

[[m:Kernel#arg_config]] ��Ʊ���Ǥ�����
--with-config ���ץ������ͤ����򻲾Ȥ��ޤ���

--- enable_config(config[, default])
#@todo

[[m:Kernel#arg_config]] ��Ʊ���Ǥ�����
--enable-config ���ץ����
�ޤ���--disable-config ���ץ������ͤ����򻲾Ȥ��ޤ���

--- create_header
#@todo

[[m:Kernel#have_func]] �ʤɤθ�����̤򸵤ˡ�

  #define HAVE_FUNC 1
  #define HAVE_HEADER_H 1

�Τ褦�������������� extconf.h �ե�������������ޤ���

--- dir_config(target[, default])
--- dir_config(target[, idefault, ldefault])
#@todo

configure ���ץ����
--with-TARGET-dir,
--with-TARGET-include,
--with-TARGET-lib
��桼���� extconf.rb �˻���Ǥ���褦�ˤ��ޤ���

--with-TARGET-dir ���ץ�����
�����ƥ�ɸ��ǤϤʤ���
�إå��ե������饤�֥�꤬����ǥ��쥯�ȥ��ޤȤ�ƻ��ꤹ�뤿��˻Ȥ��ޤ���
�桼���� extconf.rb �� --with-TARGET-dir=PATH ����ꤷ���Ȥ���
[[m:$CFLAGS]] �� "-IPATH/include" ��
[[m:$LDFLAGS]] �� "-LPATH/lib" ��
���줾���ɲä��ޤ���

--with-TARGET-include ���ץ�����
�����ƥ�ɸ��ǤϤʤ��إå��ե�����Υǥ��쥯�ȥ����ꤹ�뤿��˻Ȥ��ޤ���
�桼���� extconf.rb �� --with-TARGET-include=PATH ����ꤷ���Ȥ���
[[m:$CFLAGS]] �� PATH ���ɲä��ޤ���

--with-TARGET-lib ���ץ�����
�����ƥ�ɸ��ǤϤʤ��饤�֥��Υǥ��쥯�ȥ����ꤹ�뤿��˻Ȥ��ޤ���
�桼���� extconf.rb �� --with-TARGET-lib=PATH ����ꤷ���Ȥ���
[[m:$CFLAGS]] �� PATH ���ɲä��ޤ���

�ʾ� 3 �Ĥ� configure ���ץ���󤬤��������ꤵ��Ƥ��ʤ��Ȥ��ϡ�
�ǥե�����ͤȤ��ư��� default��idefault��ldefault ���ͤ��Ȥ��ޤ���
�� 2 �����Τ�Ϳ�������� "-Idefault/include" �� "-Ldefault/lib" �򤽤줾���ɲä���
�� 3 ������Ϳ�������� "-Iidefault" �� "-Lldefault" �򤽤줾���ɲä��ޤ���

--- create_makefile(target[, srcdir])
#@todo

[[m:Kernel#have_library]] �ʤɤγƼ︡���η�̤򸵤ˡ�
��ĥ�饤�֥�� TARGET.so ��ӥ�ɤ��뤿��� Makefile ���������ޤ���

�� 2 ���� srcdir �� make �ѿ� srcdir ���ͤ���ꤷ�ޤ���
�����ѿ��ˤϡ������������ɤ�����ǥ��쥯�ȥ�̾����ꤷ�ޤ���
���ΰ������ά�������ϡ�extconf.rb ������ǥ��쥯�ȥ꤬�Ȥ��ޤ���

extconf.rb �����̤��Υ᥽�åɤθƤӽФ��ǽ���ޤ���

--- pkg_config(pkg)
#@todo

--- what_type?
#@todo

--- create_header
#@todo

--- checking_for
#@todo

--- try_run
#@todo

--- try_compile
#@todo

--- try_static_assert
#@todo

== Constants

--- CONFIG
#@todo

[[m:Config::MAKEFILE_CONFIG]] ��Ʊ���Ǥ���

--- CFLAGS
#@todo

C ����ѥ�����Ϥ���륳�ޥ�ɥ饤�󥪥ץ����Ǥ���
�����ͤ� Makefile �ˤ�ȿ�Ǥ���ޤ���

--- LINK
#@todo

��󥫤�ư����Ȥ��Υ��ޥ�ɥ饤��Υե����ޥåȤǤ���
[[m:Kernel#try_link]] �ʤɤ����Ѥ��ޤ���

--- CPP
#@todo

�ץ�ץ����å���ư����Ȥ��Υ��ޥ�ɥ饤��Υե����ޥåȤǤ���
[[m:Kernel#try_cpp]] �ʤɤ����Ѥ��ޤ���

== Special Variables

#@# --- $config_cache
#@#     �����ѿ��� obsolete �Ǥ������߻��Ѥ���Ƥ��ޤ���
--- $srcdir
#@todo

Ruby ���󥿥ץ꥿�� make �����Ȥ��Υ������ǥ��쥯�ȥ�Ǥ���

--- $libdir
#@todo

Ruby �Υ饤�֥����֤��ǥ��쥯�ȥ�Ǥ���
�̾�� "/usr/local/lib/ruby/�С������" �Ǥ���

--- $archdir
#@todo

�ޥ����ͭ�Υ饤�֥����֤��ǥ��쥯�ȥ�Ǥ���
�̾�� "/usr/local/lib/ruby/�С������/arch" �Ǥ���

--- $sitelibdir
#@todo

�����ȸ�ͭ�Υ饤�֥����֤��ǥ��쥯�ȥ�Ǥ���
�̾�� "/usr/local/lib/ruby/site_ruby/�С������" �Ǥ���

--- $sitearchdir
#@todo

�����ȸ�ͭ�Ǥ��ĥޥ����ͭ�Υ饤�֥����֤��ǥ��쥯�ȥ�Ǥ���
�̾�� "/usr/local/lib/ruby/site_ruby/�С������/arch" �Ǥ���

--- $hdrdir
#@todo

Ruby �Υإå��ե����� ruby.h ��¸�ߤ���ǥ��쥯�ȥ�Ǥ���
�̾�� [[m:$archdir]] ��Ʊ���ǡ�"/usr/local/lib/ruby/�С������/arch" �Ǥ���

--- $topdir
#@todo

��ĥ�饤�֥��� make ���뤿��Υإå��ե����롢
�饤�֥������¸�ߤ���ǥ��쥯�ȥ�Ǥ���
�̾�� [[m:$archdir]] ��Ʊ���ǡ�"/usr/local/lib/ruby/�С������/arch" �Ǥ���

--- $defs
#@todo

��ĥ�饤�֥��򥳥�ѥ��뤹��Ȥ��Υޥ����������ꤹ������Ǥ���

�����ѿ����ͤϡ��㤨��

  ["-DHAVE_FUNC", "-DHAVE_HEADER_H"]

�Τ褦�ʷ���������Ǥ���

[[m:Kernel#have_func]] �ޤ��� [[m:Kernel#have_header]]
��ƤӽФ��ȡ����θ�����̤� $defs ���ɲä���ޤ���

[[m:Kernel#create_header]]
�Ϥ����ѿ����ͤ򻲾Ȥ��ƥإå��ե�������������ޤ���

--- $libs
#@todo

��ĥ�饤�֥����󥯤���Ȥ���
���˥�󥯤����饤�֥�����ꤹ��ʸ����Ǥ���

�����ѿ����ͤϡ��㤨��

  "-lfoo -lbar"

�Τ褦�ʷ�����ʸ����Ǥ���

[[m:Kernel#have_library]] �ޤ��� [[m:Kernel#find_library]]
��ƤӽФ��ȡ����θ�����̤�
�֤˶����Ϥ��ߤĤ� $libs ��Ϣ�뤵��ޤ���

--- $CFLAGS
#@todo

��ĥ�饤�֥��򥳥�ѥ��뤹��Ȥ��� C ����ѥ���Υ��ץ����䡢
�إå��ե�����Υǥ��쥯�ȥ����ꤹ��ʸ����Ǥ���

[[m:Kernel#dir_config]] �θ�������������ȡ�
�����ѿ����ͤ� " -Idir" ���ɲä���ޤ���

--- $LDFLAGS
#@todo

��ĥ�饤�֥����󥯤���Ȥ��Υ�󥫤Υ��ץ����
�饤�֥��ե�����Υǥ��쥯�ȥ����ꤹ��ʸ����Ǥ���

[[m:Kernel#find_library]] �ޤ��� [[m:Kernel#dir_config]]
�θ�������������ȡ�$LDFLAGS ���ͤ� "-Ldir" ���ɲä��ޤ���

#@# �����餯�桼���˲�������Ƥ��ʤ��ѿ�
#@# --- $LOCAL_LIBS
#@#     �饤�֥�����ꤹ��ʸ����Ǥ���
#@# 
#@# --- $local_flags
#@#     ��󥫥��ץ�������ꤹ��ʸ����Ǥ���