= ruby 1.6 feature

ruby version 1.6 �ϰ����ǤǤ��������ǤǤ��ѹ��ϥХ��������ᥤ��
�ˤʤ�ޤ���

((<stable-snapshot|URL:ftp://ftp.netlab.co.jp/pub/lang/ruby/stable-snapshot.tar.gz>)) �ϡ������������������Ǥκǿ��������Ǥ���

== 1.6.8 (2002-12-24) -> stable-snapshot

: 2003-01-22: errno

    EAGAIN �� EWOULDBLOCK ��Ʊ���ͤΥ����ƥ�ǡ�EWOULDBLOCK ���ʤ��ʤ�
    �Ƥ��ޤ��������ߤϡ����Τ褦�ʥ����ƥ�Ǥϡ�EWOULDBLOCK �ϡ�EAGAIN 
    �Ȥ����������Ƥ��ޤ���(����� 1.6.7 �Ȥϰۤʤ��ư�Ǥ�)

        p Errno::EAGAIN
        p Errno::EWOULDBLOCK

        => ruby 1.6.7 (2002-03-01) [i586-linux]
           Errno::EAGAIN
           Errno::EWOULDBLOCK

        => ruby 1.6.8 (2002-12-24) [i586-linux]
           Errno::EAGAIN
           -:2: uninitialized constant EWOULDBLOCK at Errno (NameError)

        => ruby 1.6.8 (2003-02-13) [i586-linux]
           Errno::EAGAIN
           Errno::EAGAIN

== 1.6.7 (2002-03-01) -> 1.6.8 (2002-12-24)

: 2002-10-02: Thread (cygwin)

  Cygwin �ǡ�Thread �����ؤ����Ԥ��ʤ����Ȥ�����ޤ�����
  ((<ruby-list:36058>)), ((<ruby-list:24637>))

: 2002-10-01: Socket (win)

  Windows �ǤΥ����åȤ����꤬1�Ĳ�褵�줿�褦�Ǥ���(�ɤΤ褦�����꤫��
  ���ܤΥ᡼�뤬�狼��ޤ���Ǥ�������select���ɤ߹��߲�ǽ�ˤʤä��Τ�
  �������֤����Ȥ�������ʤΤ������Ǥ�) ((<ruby-talk:40015>)),
  ((<ruby-win32:366>))

: 2002-09-12: Thread.status (?)

  �����ʥ�� trap �ǥȥ�åפ����Ȥ��˥���åɤξ��֤��ݻ����Ƥ��ʤ���
  �����᥷���ʥ�˳����ޤ줿����åɤξ��֤����������ʤ뤳�Ȥ������
  ����((<ruby-talk:40337>)), ((<ruby-core:00019>))

: 2002-09-11: Queue#((<Queue/pop>))

  Queue#pop �˶�����֤����꤬����ޤ��� ((<ruby-dev:17223>))

: 2002-09-11: SizedQueue.new

  ������ 0 �ʲ�������Ĥ���Х�����������ޤ�����

: 2002-09-05: ((<��ƥ��/��Ÿ��>))

  stable snapshot �ǡ����������Ÿ����Υ������Ȥϡ��Хå�����å��奨
  �������פ�ɬ�פˤʤäƤ��ޤ������������ѹ��ϸ������ޤ�����

        p "#{ "" }"

        => ruby 1.6.7 (2002-03-01) [i586-linux]
           ""

        => -:1: warning: bad substitution in string
           ruby 1.6.7 (2002-09-12) [i586-linux]
           "#{  }"

        => ruby 1.6.7 (2002-09-25) [i586-linux]
           ""

  �����1.7����ΥХå��ݡ��ȤǤϤ���ޤ��󡣥����Ȥΰ����ʤɤϡ�1.7 
  �Ȥϰۤʤ�ޤ���(((<ruby 1.7 feature>)) �� 2002-06-24 �⻲��)

        p "#{ "" # comment }"
        => ruby 1.6.8 (2002-10-04) [i586-linux]
           ""
        => -:1: parse error
           ruby 1.7.3 (2002-10-04) [i586-linux]

: SizedQueue#deq, #shift
: SizedQueue#enq

  �ɲ�(push, pop ����̾)������餬�������Ƥ��ʤ��ä����ᡢenq �ʤɤ�
  �ƤӽФ����Ȥ������ѡ����饹 Queue �� enq ���¹Ԥ���Ƥ��ޤ�����

: 2002-09-11: ((<tempfile/Tempfile#size>))

  �ɲ� ((<ruby-dev:17221>))

: 2002-09-09

  mswin32 �Ǥ� mingw32 �Ǥ� ruby �ǡ�1.6.6�κ����� ruby �λҥץ������˴Ķ��ѿ����Ϥ�ʤ�
  �Х�������ޤ�����((<ruby-dev:18236>))

: 2002-09-03

  Bison ����Ѥ��ƥ���ѥ��뤷�� Ruby �ǡ�ʣ����Υ饤�֥������ɤ��
  ���Ȥ���®�٤����夷�ޤ�����(Bison ����Ѥ��ʤ���硢�����ɤ�������
  ��Ū�� GC ���¹Ԥ���뤿��饤�֥������ɤμ¹�®�٤��㲼����Τ���
  ���Ǥ�) ((<ruby-dev:18145>))

: 2002-08-20 File.expand_path

  Cygwin 1.3.x ((<ruby-bugs-ja:PR#299>))

        p File.expand_path('file', 'c:/')

        => ruby 1.6.7 (2002-03-01) [i586-linux]
           /tmp/c:/file
        => ruby 1.6.7 (2002-08-21) [i586-linux]
           c:/file

: 2002-08-19 Thread (win)

  Ruby �Υ���åɤ� Win32 �ι�¤���㳰��Win32 API ����Υ�����Х�
  ����ޤ�ˤ�Ʊ���˻Ȥ�������Ƥ��ޤ��Զ�礬�������줿�Τ������Ǥ���
  ((<ruby-win32:273>))

: 2002-08-12 Hash#==

  Hash ���֥������Ȥϥǥե������ (((<Hash/default>))) �� == ��������
  �Ȥ����������Ȥߤʤ����褦�ˤʤ�ޤ�����

        p Hash.new("foo") == Hash.new("bar")

        => ruby 1.6.7 (2002-03-01) [i586-linux]
           true
        => ruby 1.6.7 (2002-08-21) [i586-linux]
           false

# : 2002-08-01 IO#read, gets ..., etc.
# 
#    File::NONBLOCK ����ꤷ�� IO ���ɤ߹��ߤ� EWOULDBLOCK ��ȯ������ȡ�
#    ����ޤ��ɤ���ǡ����������뤳�Ȥ�����ޤ�����
#    ((<ruby-dev:17855>))
#    ((-����Ϥޤ��ޡ�������Ƥޤ���1.6�����뤫�������Ǥ���-))

: 2002-07-11 String#slice!

  �ϰϳ���ʸ�������ꤷ���Ȥ����㳰���֤���礬����ޤ���������� nil 
  ���֤��褦�ˤʤ�ޤ�����(String#[]��String#slice ��Ʊ����̤��֤���
  �������ȤǤ�)

        p "foo".slice!("bar")   # <- �������餳����� nil ���֤��Ƥ���
        p "foo".slice!(5,10)

        => ruby 1.6.7 (2002-03-01) [i586-linux]
           nil
           -:2:in `slice!': index 5 out of string (IndexError)
                from -:2
        => ruby 1.6.7 (2002-08-01) [i586-linux]
           nil
           nil

: 2002-07-05 String#split

  �ǽ�ΰ����� nil �����Ǥ���褦�ˤʤ�ޤ�����((<ruby-talk:43513>)) 
  ���ξ�硢$; ��ʬ��ʸ����Ȥ��ƻ��Ѥ��ޤ��������ޤǤ� $; ��ͭ���ˤ�
  ��Τϰ�����ά�������Ǥ�����

    $; = ":"
    p "a:b:c".split(nil)
    => -:2:in `split': bad separator (ArgumentError)
            from -:2
       ruby 1.6.7 (2002-03-01) [i586-linux]

    => ruby 1.6.7 (2002-07-30) [i586-linux]
       ["a", "b", "c"]

: 2002-06-15 Dir.glob

  ��󥯤��ڤ줿����ܥ�å���󥯤��Ф��ơ�Dir.glob ���ޥå����ޤ���
  �Ǥ�����

        File.symlink("foo", "bar")
        p Dir.glob("bar")
        => ruby 1.6.7 (2002-03-01) [i586-linux]
           []
        => ruby 1.6.7 (2002-08-01) [i586-linux]
           ["bar"]

: 2002-06-13 Hash[]

  Hash[] �ǡ������Ȥʤ�ʸ����� dup & freeze ���Ƥ��ޤ���Ǥ�����

        a = "key"
        h = Hash[a,"val"]
        h.keys[0].upcase!
        p a
        => ruby 1.6.7 (2002-03-01) [i586-linux]
           "KEY"
        => -:3:in `upcase!': can't modify frozen string (TypeError)
                from -:3
           ruby 1.6.7 (2002-08-01) [i586-linux]

: 2002-06-10 Fixnum#>>, <<

  ��ο����Ф��Ʊ����եȤ���� 0 �ˤʤ뤳�Ȥ�����ޤ�����
  ((<ruby-bugs-ja:PR#247>))

  ��ο�������ˤ��������ե�(�Ĥޤ걦���ե�)��Ʊ�ͤˤ������ʵ�ư�򤷤�
  ���ޤ�����((<ruby-bugs-ja:PR#248>))

        p(-1 >> 31)
        => ruby 1.6.7 (2002-03-01) [i586-linux]
           0
        => ruby 1.6.7 (2002-08-01) [i586-linux]
           -1

        p(-1 << -1)
        => ruby 1.6.7 (2002-03-01) [i586-linux]
           -2147483649
        => ruby 1.6.7 (2002-08-01) [i586-linux]
           -1

: 2002-06-05
: ((<Math/Math.acosh>))
: ((<Math/Math.asinh>))
: ((<Math/Math.atanh>))

  �ɲá�

: 2002-06-03
: String#[]=

  ����ǥå����Ȥ��ƻ��ꤷ��ʸ���󤬥쥷���Ф˴ޤޤ�ʤ����ˡ����⤻
  �����դ��֤��Ƥ��ޤ�����

    foo = "foo"
    p foo["bar"] = "baz"
    p foo

    => ruby 1.6.7 (2002-03-01) [i586-linux]
       "baz"
       "foo"
    => -:2:in `[]=': string not matched (IndexError)
            from -:2
       ruby 1.6.7 (2002-07-30) [i586-linux]

: 2002-06-03 sprintf()

  "%d" �ǰ����������ˤ���Ȥ��ˡ�((<�Ȥ߹��ߴؿ�/Integer>)) ��Ʊ����§��
  ���Ѥ���褦�ˤʤ�ޤ�����

        p sprintf("%d", nil)

        => -:1:in `sprintf': no implicit conversion from nil (TypeError)
                from -:1
           ruby 1.6.7 (2002-03-01) [i586-linux]

        => ruby 1.6.7 (2002-07-30) [i586-linux]
           "0"

: 2002-05-23 -* ���ץ����(?)

  �����ޤǡ�

    #! ruby -*- mode: ruby -*-

  �Τ褦�� Emacs �� '-*-' �������Ѥ���������ץȤΤ���� -* �ʹߤ�̵
  �뤹��(���⤷�ʤ����ץ����Ȥ���ǧ��)����褦�ˤʤäƤ��ޤ���������
  �����̰����Ϥʤ��ʤ�ޤ�����Emacs �� '-*-' ����ϡ�2���ܤ˽񤯤褦��
  ����٤��Ǥ���((<ruby-dev:17193>))

        ruby '-*' -v
        => ruby 1.6.7 (2002-03-01) [i586-linux]

        => ruby: invalid option -*  (-h will show valid options)

: 2002-05-22 parsedate

  �С�����󥢥å�((<ruby-dev:17171>))

: 2002-05-22 -T ���ץ����

  ruby �Υ��ޥ�ɥ饤�󥪥ץ���� -T �θ�˶�����֤�����¾�Υ��ץ���
  ���³����ȡ�-T�ʹߤΥ��ץ����̵���ˤʤäƤ��ޤ�����-T �θ�Ͽ�
  ���ʳ���³������硢���ץ����Ȥߤʤ��褦�ˤʤ�ޤ���(-0 ���ץ����
  ��Ʊ��) ((<ruby-dev:17179>))

        ruby -Tv  # -v ��̵�� (ruby 1.6.7 (2002-03-01) [i586-linux])

        => ruby: No program input from stdin allowed in tainted mode (SecurityError)

        => ruby 1.6.7 (2002-07-30) [i586-linux]

: 2002-05-20 IO#close

  �������Υѥ��פ� dup �� close_write ����ȥ��顼�ˤʤäƤ��ޤ�����
  ((<ruby-dev:17155>))

    open("|-","r+") {|f|
      if f
        f.dup.close_write
      else
         sleep 1
      end
    }

    => ruby 1.6.7 (2002-03-01) [i586-linux]
       -:3:in `close_write': closing non-duplex IO for writing (IOError)
            from -:3
            from -:1:in `open'
            from -:1


    => ruby 1.6.7 (2002-07-30) [i586-linux]

: 2002-05-02 Regexp.quote

  # �ϥХå�����å��奯�����Ȥ���褦�ˤʤ�ޤ���������ϡ�quote ����
  ����ɽ���� //x ���������������褦�ˤ��뤿��Ǥ���
  ((<ruby-bugs-ja:PR#231>))

        p Regexp.quote("#")

        p /a#{Regexp.quote("#")}b/x =~ "ab"

        => -:3: warning: ambiguous first argument; make sure
           ruby 1.6.7 (2002-03-01) [i586-linux]
           "#"
           0

        => -:3: warning: ambiguous first argument; make sure
           ruby 1.6.7 (2002-07-30) [i586-linux]
           "\\#"
           nil

: 2002-04-29: rb_find_file()

  $SAFE >= 4 �ǡ����Хѥ�����Ǥʤ���硢SecurityError �㳰��ȯ������
  �褦�ˤʤ�ޤ�����

: 2002-04-26: Regexp.quote

  ((<ruby-bugs-ja:PR#231>))

        p Regexp.quote("\t")

        p /a#{Regexp.quote("\t")}b/x =~ "ab"

        => -:3: warning: ambiguous first argument; make sure
           ruby 1.6.7 (2002-03-01) [i586-linux]
           "\t"
           0

        => -:3: warning: ambiguous first argument; make sure
           ruby 1.6.7 (2002-05-04) [i586-linux]
           "\\t"
           nil

: 2002-04-20: Regexp#inspect

  /x �ե饰�դ�������ɽ�����֥������Ȥ� inspect �����Ԥ� \n ���Ѵ�����
  ���ޤ�����((<ruby-bugs-ja:PR#225>))

        p /a
                b/x

        => -:1: warning: ambiguous first argument; make sure
           ruby 1.6.7 (2002-03-01) [i586-linux]
           /a\n                b/x

        => -:1: warning: ambiguous first argument; make sure
           ruby 1.7.2 (2002-04-24) [i586-linux]
           /a
                           b/x
: 2002-04-19: ��λ����

  �ʲ��Υ�����ץȤ� 2 �󥷥��ʥ������ʤ��Ƚ�λ���ʤ��Զ�礬������
  ��ޤ�����((<ruby-bugs-ja:PR#223>))

    trap(:TERM, "EXIT")

    END{
      puts "exit"
    }

    Thread.start { Thread.stop }
    sleep

: 2002-04-17: Regexp#inspect

  ((<ruby-bugs-ja:PR#222>))

    p %r{\/}

    => ruby 1.6.7 (2002-03-01) [i586-linux]
       /\\//

    => ruby 1.6.7 (2002-05-04) [i586-linux]
       /\//

: 2002-04-15: pack('U')

  pack('U') �� unpack('U') ����ȸ������ʤ��Х�����������ޤ�����
  (unpack �ϡ��Х���ñ�̤Ǥʤ�ʸ��ñ�̤ν����ˤʤ�ޤ���)
  ((<ruby-bugs-ja:PR#220>))

    p [128].pack("U")
    p [128].pack("U").unpack("U")

    => ruby 1.6.7 (2002-03-01) [i586-linux]
       "\302\200"
       [0]

    => ruby 1.6.7 (2002-05-04) [i586-linux]
       "\302\200"
       [128]

: 2002-04-11: IO#write

  �����åȤ�ѥ��פ��Ф��� EPIPE �θ��Ф˼��Ԥ��뤳�Ȥ�����ޤ�����
  ((<ruby-dev:16849>))

: 2002-04-11: ((<"cgi/session">))    (*�ɥ������̤ȿ��*)

  support for multipart form.

: 2002-04-10: Object#((<Object/remove_instance_variable>))

  ���ꤷ�����󥹥����ѿ����������Ƥ��ʤ�����㳰 NameError �򵯤�
  ���褦�ˤʤ�ޤ�����((<ruby-bugs-ja:PR#216>))

        Object.new.instance_eval {
          p remove_instance_variable :@foo
        }
        => ruby 1.6.7 (2002-03-01) [i586-linux]
           nil

        => -:2:in `remove_instance_variable': instance variable @foo not defined (NameError)
           ruby 1.6.7 (2002-04-10) [i586-linux]

: 2002-04-04: Integer#((<Integer/step>))

  ��������� 1 ���⾮�������� 0 ����ꤷ���ȸ��ʤ��쥨�顼�ˤʤä�
  ���ޤ�����

    1.step(2, 0.1) {|f| p f }

    => -:1:in `step': step cannot be 0 (ArgumentError)
            from -:1
       ruby 1.6.7 (2002-03-01) [i586-linux]

    => ruby 1.6.7 (2002-04-10) [i586-linux]
       1
       1.1
        :
       1.9

: 2002-04-01: ((<�Ȥ߹����ѿ�/$~>))

  $~ �� nil �������Ǥ��ʤ��Х�����������ޤ�����((<ruby-dev:16697>))

    /foo/ =~ "foo"
    p $~
    $~ = nil
    p $~
    => ruby 1.6.7 (2002-03-01) [i586-linux]
       #<MatchData:0x401b1be4>
       -:3: wrong argument type nil (expected Match) (TypeError)
                                              ^^^^^ MatchData �δְ㤤
    => ruby 1.6.7 (2002-04-04) [i586-linux]
       #<MatchData:0x401b1c98>
       nil

: 2002-03-25 ((<BasicSocket/BasicSocket.do_not_reverse_lookup>))

  $SAFE > 3 ���ͤ�����Ǥ��ʤ��ʤ�ޤ�����
  ((<ruby-dev:16554>))

: 2002-03-23 IO#((<IO/read>))

  �������� 0 ����ȤΤ���ե�����(Linux �� /proc �ե����륷���ƥ�Ǥ�
  �Τ褦�ʾ�礬����ޤ�)�� File#read �ʤɤ��ɤ�ʤ��Х�����������ޤ�
  ����

        p File.open("/proc/#$$/cmdline").read

        => ruby 1.6.7 (2002-03-01) [i586-linux]
           ""

        => ruby 1.6.7 (2002-03-29) [i586-linux]
           "ruby-1.6\000-v\000-"

: 2002-03-22 ((<Module/module_eval>))

  ((<Module/module_eval>)) �Υ֥��å��������䥯�饹�ѿ��Υ������פ�
  �Ѥ�뤳�ȤϤʤ��ʤ�ޤ�����((<ruby-dev:17876>))

        class Foo
          FOO = 1
          @@foo = 1
        end

        FOO = 2
        @@foo = 2

        Foo.module_eval { p FOO, @@foo }

        => ruby 1.6.7 (2002-03-01) [i586-linux]
           1
           1

        => ruby 1.6.7 (2002-03-29) [i586-linux]
           2
           2

: 2002-03-22 ((<"net/http">))

  Net::HTTP.new ���֥��å��ʤ��ΤȤ��� nil ���֤��Ƥ��ޤ�����
  ((<ruby-bugs-ja:PR#214>))

  net/protocol �Ϻ������������ˤ���褦�ǡ����ν�������
  ����Х����������Ǥ���

: 2002-03-20 ((<File/File.expand_path>))

  ����β����̤줬����ޤ�����((<ruby-bugs:PR#276>))

: 2002-03-18 ʸ�����ƥ��

  ���������ɤΰ����� #{..} ����ʤɤ��Դ�������ʬ������ޤ�����
  ((<ruby-list:34478>))

        #! ruby -Ks
        p a = "#{"ɽ"}"
        => -:1: compile error in string expansion (SyntaxError)
           -:1: unterminated string meets end of file
           ruby 1.6.7 (2002-03-15) [i586-linux]
        => ruby 1.6.7 (2002-03-19) [i586-linux]
           "ɽ"

        #! ruby -Ks
        p %[ɾ��]
        => -:2: parse error
                   p %[ɾ��]
                           ^
           ruby 1.6.7 (2002-03-15) [i586-linux]

        => ruby 1.6.7 (2002-03-19) [i586-linux]
           "ɾ��"

: 2002-03-16 $~

  ����ɽ���ޥå��Υ᥽�åɤ��ºݤˤ������ǥޥå���¹Ԥ��ʤ����� 
  $~ �ξ��֤򥯥ꥢ���Ƥ��ޤ���Ǥ�����
  ((<ruby-bugs-ja:PR#208>))

        /foo/ =~ "foo"
        /foo/ =~ nil
        p $~

        /foo/ =~ "foo"
        $_ = nil; ~"foo"
        p $~

        /foo/ =~ "foo"
        "foo".index(/bar/, 4)
        p $~

        /foo/ =~ "foo"
        "foo".rindex(/bar/, -4)
        p $~

        => ruby 1.6.7 (2002-03-06) [i586-linux]
           #<MatchData:0x401b1be4>
           #<MatchData:0x401b198c>
           #<MatchData:0x401b1644>
           #<MatchData:0x401b1414>
        => ruby 1.6.7 (2002-03-19) [i586-linux]
           nil
           nil
           nil
           nil

: 2002-03-14 ��ĥ�饤�֥��� autoload

  ��ĥ�饤�֥����Ф��� autoload �������Ƥ��ޤ���Ǥ�����((<ruby-dev:16379>))

    autoload :Fcntl, "fcntl"
    require "fcntl"

    => -:2:in `require': uninitialized constant Fcntl (NameError)
            from -:2
       ruby 1.6.7 (2002-03-01) [i586-linux]

    => ruby 1.6.7 (2002-03-15) [i586-linux]

: 2002-03-13 ((<getopts>))

  refine. ((<ruby-dev:16193>)), ((<ruby-dev:16213>))

: 2002-03-11 ����ɽ����� 8 �ʥ�����

  ����ɽ����� \nnn �ˤ�� 8 �ʵ�ˡ����Ƭ�� 0 �ξ�������4��������
  ���ޤ�����((<ruby-bugs-ja:PR#207>))

    p /\0001/ =~ "\0001"   # equivalent to "\0" + "1"
    => -:1: warning: ambiguous first argument; make sure
       ruby 1.6.7 (2002-03-01) [i586-linux]
       nil
    => -:1: warning: ambiguous first argument; make sure
       ruby 1.6.7 (2002-03-15) [i586-linux]
       0

: 2002-03-11 trap

  ((<ruby-bugs-ja:PR#206>))

    trap('EXIT','Foo')
    => -:1: [BUG] Segmentation fault
       ruby 1.6.7 (2002-03-01) [i586-linux]
    => ruby 1.6.7 (2002-03-15) [i586-linux]

: 2002-03-10 �᥽�åɤ������

  �ʲ��Υ᥽�åɤ�����ͤ��������ʤ�ޤ�����((<ruby-bugs-ja:PR#205>))

  * ((<Enumerable/each_with_index>)) �� self ���֤��褦�ˤʤä�(������ nil)
  * ((<Process/Process.setpgrp>)) ���֤��ͤ�������ä���
  * ((<String/ljust>)), ((<String/rjust>)), ((<String/center>)) �η�̤�
    �Ѳ����ʤ��Ƥ��� dup ����ʸ������֤��褦�ˤʤä�

: 2002-03-08 class variable

  ((<ruby-talk:35122>))

    class C
      class << self
        def test
          @@cv = 5
          p @@cv
        end
      end

      test
    end
    => -:5:in `test': uninitialized class variable @@cv in C (NameError)
            from -:9
       ruby 1.6.7 (2002-03-01) [i586-linux]

    => ruby 1.6.6 (2001-12-26) [i586-linux]
       5

: 2002-03-03 ((<Marshal/Marshal.load>))

  Marshal.load �� 1.7 �Υ᥽�å� Proc#yield ��Ƥ�Ǥ��ޤ�����
  ((<ruby-dev:16178>))

    Marshal.load(Marshal.dump('foo'), proc {|o| p o})
    => -:1:in `load': undefined method `yield' for #<Proc:0x401b1b30> (NameError)
            from -:1
       ruby 1.6.7 (2002-03-01) [i586-linux]

    => ruby 1.6.6 (2001-12-26) [i586-linux]
       "foo"

== 1.6.6 (2001-12-26) -> 1.6.7 (2002-03-01)

: 2002-02-20 true/false/nil ���ðۥ᥽�å����

  ����鵿���ѿ����ðۥ��饹����������ðۥ᥽�åɤ�����Ǥ���褦�ˤ�
  ��ޤ�����

        class <<true
          def foo
           "foo"
          end
        end
        p true.foo
        => -:1: no virtual class for true (TypeError)
           ruby 1.6.6 (2001-12-26) [i586-linux]

        => ruby 1.6.7 (2002-03-01) [i586-linux]
           "foo"

: ((<time>)), URI

  �ɲä���ޤ�����

: Ruby/Tk

  �Х���������ǽ�ɲ� ((<ruby-dev:16139>)),((<ruby-dev:16153>))��

: ���ͥ�ƥ��� `_'

  `_' ���֤�����ε�§����ľ���졢String#hex �ʤɤο����Ѵ��᥽�å�
  �ε�ư�ȶ��˵�§�����줵��ޤ�����((<rubyist:1018>)), ((<ruby-dev:15684>)),
  ((<ruby-dev:15757>))

: ((<Module/include>))

  �⥸�塼�뤬�Ƶ�Ū�� include ����ʤ��褦�ˤʤ�ޤ�����

    module Foo; end
    module Bar; include Foo; end
    module Foo; include Bar; end

    p Foo.ancestors

    => ruby 1.6.6 (2001-12-26) [i586-linux]
       [Foo, Bar, Foo]

    => -:3:in `append_features': cyclic include detected (ArgumentError)
            from -:3:in `include'
            from -:3
       ruby 1.6.6 (2002-01-28) [i586-linux]

: �᥽�åɤ������

  �ʲ��Υ᥽�åɤ�����ͤ��������ʤ�ޤ�����
  ((<ruby-bugs-ja:PR#182>)), ((<rubyist:1016>))

  * Hash#default= �����դ��֤��褦�ˤʤä�(������ self ���֤��Ƥ���)��

  * Dir#pos= �����դ��֤��褦�ˤʤä�(������ self ���֤��Ƥ���)��
    (Dir#seek �ϡ��Ѥ�餺 self ���֤��ޤ�)

  * Dir.glob ���֥��å���ȼ���Ȥ� nil ���֤��褦�ˤʤä�(������ false)

  * IO#close �����������Ѥߤ� IO ���Ф��� IOError �򵯤����褦�ˤʤä���

  * IO#each_byte �� self ���֤��褦�ˤʤä�(������ nil)

: rb_define_module_under()

  C �ؿ� rb_define_module_under() �ǥ⥸�塼����������Ȥ���Ʊ̾����
  ���������������Ƥ���ȼ��Ԥ��Ƥ��ޤ�����((<ruby-talk:30203>))

        Constants = 1
        require 'syslog'
        p Syslog::Constants

        => -:2:in `require': Syslog::Fixnum is not a module (TypeError)
                from -:2
           ruby 1.6.6 (2001-12-26) [i586-linux]

        => ruby 1.6.6 (2002-01-07) [i586-linux]
           Syslog::Constants

  ���ΥХ��ˤ�� 1.6.7 ���ᤤ�����˥�꡼������뤫�⤷��ޤ���
  ((<ruby-talk:30387>))(��äѤ���ʤ��ȤϤʤ��ä��褦�Ǥ���
  ����򸫤ơ�1.6.6 �� stable-snapshot ����Ѥ��Ƥ������ϡ�2002/1/30 
  �ΰʲ����ѹ�(ChangeLog)

        * re.c (rb_reg_search): should set regs.allocated.

  �ǡ�����꡼����������褦�ˤʤäƤ뤳�Ȥ����դ��Ƥ���������
  2002/2/13 �ʹߤν����Ǥ�ľ�äƤޤ����äȰ��٥ϥޥä��Τǽ񤤤Ƥ�����
  ��)��

== 1.6.5 (2001-09-19) -> 1.6.6 (2001-09-19)

: ((<Syslog>))

  �ɲä���ޤ�����

: CGI

  Netscape(�С������ϡ�) �ΥХ����н褷�ޤ���
  ((<ruby-list:32089>))

: Time#localtime
: Time#gmtime

  �ե꡼������ Time ���֥������Ȥ��Ф��ư��٤����ƤӽФ�������ޤ�����

        t = Time.new.freeze
        p t.gmtime
        p t.localtime

        => -:2:in `gmtime': can't modify frozen Time (TypeError)
                from -:2
           ruby 1.6.5 (2001-09-19) [i586-linux]

        => ruby 1.6.5 (2001-11-01) [i586-linux]
           Mon Nov 05 18:08:34 UTC 2001
           -:3:in `localtime': can't modify frozen Time (TypeError)
                from -:3

: File::SEPARATOR
: File::ALT_SEPARATOR
: File::PATH_SEPARATOR
: RUBY_PLATFORM
: RUBY_RELEASE_DATE
: RUBY_VERSION

  �����ϡ�freeze ���줿ʸ����ˤʤ�ޤ�����

        p File::SEPARATOR.frozen?
        p File::ALT_SEPARATOR.frozen?
        p File::PATH_SEPARATOR.frozen?

        => ruby 1.6.5 (2001-09-19) [i586-linux]
           false
           false
           false

        => ruby 1.6.5 (2001-11-01) [i586-linux]
           true
           false  # �����Ǥϼ¹ԴĶ���Linux�ʤΤ� ALT_SEPARATOR �� nil
           true

: Integer[nth]

  �礭���ͤΥ���ǥå������Ф����㳰��ȯ�����Ƥ��ޤ�����
  ((<ruby-bugs-ja:PR#114>))

        p(-1[10000000000])

        => -:1:in `[]': bignum too big to convert into `int' (RangeError)
                from -:1
           ruby 1.6.5 (2001-09-19) [i586-linux]

        => ruby 1.6.5 (2001-11-01) [i586-linux]
           1

  ��������Υ���ǥå������Ф��� 0 ���֤��褦�ˤʡ������äƤޤ��󡣤��졩
  ((<ruby-bugs-ja:PR#122>))

        p(-1[-1])

        => ruby 1.6.5 (2001-09-19) [i586-linux]
           1
        => ruby 1.6.5 (2001-11-01) [i586-linux]
           1

: Numeric#remainder

  ((<ruby-bugs-ja:PR#110>))

        p( 3.remainder(-3))
        p(-3.remainder(3))

        => ruby 1.6.5 (2001-09-19) [i586-linux]
           3
           -3
        => ruby 1.6.5 (2001-11-01) [i586-linux]
           0
           0

: END { ... }

  END �֥��å������ END �֥��å����¹Ԥ���Ƥ��ޤ���Ǥ�����
  ((<ruby-bugs-ja:PR#107>))

        END {
          p 1
          END { p 2 }
        }

        => ruby 1.6.5 (2001-09-19) [i586-linux]
           1

        => ruby 1.6.5 (2001-11-01) [i586-linux]
           1
           2

: String#succ

((<ruby-talk:22557>))

        p "***".succ
        p "*".succ
        p sprintf("%c", 255).succ
        p sprintf("*%c", 255).succ
        p sprintf("**%c", 255).succ

        => ruby 1.6.5 (2001-09-19) [i586-linux]
           "**+"
           "\001+"
           "\001\000"
           "\001+\000"
           "*+\000"

        => ruby 1.6.5 (2001-11-01) [i586-linux]
           "**+"
           "+"
           "\001\000"
           "+\000"
           "*+\000"

: method_missing

  �ʲ��� Segmentation Fault ���Ƥ��ޤ�����((<ruby-dev:14942>))

        Module.constants.each {|c|
          c = eval c
          if c.instance_of?(Class)
            p c
            c.instance_methods.each {|m|
              c.module_eval "undef #{m};"
            }
            c.module_eval {undef initialize}
          end
        }

        => ruby 1.6.5 (2001-09-19) [i586-linux]
           NotImplementedError
           MatchData
           Exception
           Numeric
           MatchData
           Segmentation fault

        => ruby 1.6.5 (2001-10-15) [i586-linux]
           MatchData
           NotImplementedError
           FloatDomainError
           LoadError
           Float
           Binding
           SignalException
           Module
           -:6:in `method_missing': stack level too deep (SystemStackError)

: %q(...)

  % ��ˡ�ˤ���ƥ��ɽ���Ǥ��ζ��ڤ�ʸ���Ȥ��Ʊѿ��������
  �Ǥ��ʤ��ʤ�ޤ�����

     p %q1..1

    => ruby 1.6.5 (2001-10-10) [i586-linux]
       ".."
    => -:1: unknown type of %string
            p %q1..1
                 ^
       ruby 1.6.5 (2001-10-15) [i586-linux]

: String#=~

  String#=~ �θƽФ�ξ�դȤ��ƥ��Ǥ��ä��Ȥ���®�ٽŻ�Τ���˥᥽��
  �ɥ������Ԥ�ʤ��ʤ�ޤ�����(�ºݤϡ������餳�Τ褦�ˤ��褦�Ȥ���
  �������Х��ˤ��᥽�åɤ��ƤӽФ���Ƥ���(������String#=~ �Ǥʤ� 
  Regexp#=~))

    class String
      def =~(arg)
        ["String#=~", self, arg]
      end
    end

    class Regexp
      def =~(arg)
        ["Regexp#=~", self, arg]
      end
    end

    p "foo" =~ /foo/
    p "foo" =~ Regexp.new("foo")

    => -:2: warning: discarding old =~
       -:8: warning: discarding old =~
       ruby 1.6.5 (2001-09-19) [i586-linux]
       ["Regexp#=~", /foo/, "foo"]
       ["String#=~", "foo", /foo/]

    => -:2: warning: discarding old =~
       -:8: warning: discarding old =~
       ruby 1.6.5 (2001-10-10) [i586-linux]
       0
       ["String#=~", "foo", /foo/]

  (((*�Ȥ߹��ߤΥ᥽�åɤϤ��Τ褦�ʺ�Ŭ�����Ԥ��뤳�Ȥ�����Τǥ᥽��
  �ɤκ�����θ��̤��ڤФʤ����Ȥ�������������*))�Ȥ��������᥽�åɤ�
  ��������줿���ɤ����ǡ���Ŭ���� on/off �򤷤Ƥۤ����ʤ�)

: class ���

  ���˥��饹���������Ƥ��ơ����Υ��饹�Ȱۤʤ륹���ѡ����饹������Ū
  �˻��ꤷ�ƺ���������Ȥ������ꤷ�������ѡ����饹��ȿ�Ǥ���Ƥ��ޤ���
  �Ǥ�����((<ruby-bugs-ja:PR#87>))

    class A
      p self.id
    end
    class A < String
      p self.id
      p self.superclass
    end

    => ruby 1.6.5 (2001-09-19) [i586-linux]
       537760880
       -:4: warning: already initialized constant A
       537757180
       Object
    => ruby 1.6.5 (2001-10-10) [i586-linux]
       537760960
       -:4: warning: already initialized constant A
       537757200
       String

: %w(...)

  �����ƥ�� %w(...) ����ʸ���ϴ�ˤ��ʸ�����ƥ��Ȥ���Ƚ�Ǥ����
  �������ᡢ�ʲ��Τ褦�ʥ����ɤǰ۾�ʾ��֤ˤʤäƤ��ޤ�����
  ((<ruby-bugs-ja:PR#91>))

    %w!a! "b" 
    => -:1: tried to allocate too big memory (NoMemoryError)
       ruby 1.6.5 (2001-09-19) [i586-linux]

    => -:1: parse error
           %w!a! "b" 
                    ^
       ruby 1.6.5 (2001-10-10) [i586-linux]

: Thread

  Thread#status �� aborting ���֤��Ф��� "run" ���֤��Ƥ����Х�������
  ����ޤ������ޤ���Thread#priority = val �� val �Ǥʤ� self ���֤���
  ���ޤ�����((<rubyist:0820>)), ((<ruby-dev:14903>))

: ((<Marshal>))

  ̵̾�Υ��饹���⥸�塼��� dump �Ǥ��ʤ��褦�ˤʤ�ޤ�����

    p Marshal.dump(Class.new)

    => ruby 1.6.4 (2001-06-04) [i586-linux]
       "\004\005c\031#<Class 0lx401a6b44>"

    => -:1:in `dump': can't dump anonymous class #<Class 0lx401ab980> (ArgumentError)
            from -:1
       ruby 1.6.5 (2001-10-05) [i586-linux]

: UNIXSocket#addr

  UNIXSocket#addr �����ߤ��֤��Ƥ��ޤ���(BSD �ξ�硩)��
  ((<ruby-bugs-ja:PR#85>))

        # server
        require 'socket'
        File.unlink("/tmp/sss")
        sock = UNIXServer.new("/tmp/sss").accept

        # client
        require 'socket'
        sock = UNIXSocket.new("/tmp/sss").addr

        => ["AF_UNIX", "\031((\306\031(\010"]

        => ["AF_UNIX", ""]

: ???
        ((<ruby-talk:21722>))

        class Ptr
                def initialize(obj) @obj = obj end
                def []=() @obj = obj end
                def []() @obj end
        end
        module Kernel
                def _ptr() Ptr.new(self) end
        end

        def foo(int)
                int[] += 1
        end
        x = 1._ptr
        foo(x)
        puts x[]

        => -:11: [BUG] Segmentation fault
           ruby 1.6.5 (2001-09-19) [i586-linux]

        => -:11:in `[]=': wrong # of arguments(1 for 0) (ArgumentError)
                   from -:11:in `foo'
                   from -:14
           ruby 1.6.5 (2001-10-05) [i586-linux]

: Subclass of String and Array

  String, Array �Υ��֥��饹������Υ᥽�åɤ�Ƥ֤ȡ�String, Array
  �ˤʤäƤ��ޤ�����

        class Foo < String
        end
        p Foo.new("").class
        p Foo.new("foo")[0,0].class              # String ???
        p Foo.new("foo")[1,1].class
        p Foo.new("foo").succ.class
        p Foo.new("foo").reverse.class
        p((Foo.new("foo") * 5).class)
        p Foo.new("foo").gsub(/foo/, "bar").class
        p Foo.new("foo").sub(/foo/, "bar").class
        p Foo.new("foo").ljust(10).class
        p Foo.new("foo").rjust(10).class
        p Foo.new("foo").center(10).class

        => ruby 1.6.5 (2001-09-19) [i586-linux]
           Foo
           String
           String
           String
           String
           String
           String
           Foo
           String
           String
           String

        => ruby 1.6.5 (2001-10-05) [i586-linux]
           Foo
           String
           Foo
           Foo
           Foo
           Foo
           Foo
           Foo
           Foo
           Foo
           Foo

        class Bar < Array
        end
        bar = Bar.new
        p bar.class
        p bar.push(1,2,3)
        p bar.class
        p bar[0,0].class            # => Array ???
        p bar[0,1].class
        p ((bar * 5).class)

        => -:9: warning: p (...) interpreted as method call
           ruby 1.6.5 (2001-09-19) [i586-linux]
           Bar
           [1, 2, 3]
           Bar
           Array
           Array
           Array
        => -:9: warning: p (...) interpreted as method call
           ruby 1.6.5 (2001-10-05) [i586-linux]
           Bar
           [1, 2, 3]
           Bar
           Array
           Bar
           Bar

== 1.6.4 (2001-06-04) -> 1.6.5 (2001-09-19)

: $_, $~, if a..b

  �ؿ����椫��Thread#run��Ȥ��ȡ����Υ���åɤȥ������פ�ͭ����ƥ����
  �ɤ�$_, $~�����ҥ���åɤΤ�ΤǾ�񤭤���Ƥ��ޤäƤ��ޤ�����
  ((<ruby-dev:14743>))

        def foo(t)
          t.run
        end

        t = Thread.start do
          t = $_= "sub"
          loop{Thread.stop;puts "sub:#$_"}
        end

        $_ = "main"
        t.run                   # => sub:sub
        puts "main:#$_"         # => main:main
        foo(t)                  # => sub:sub
        puts "main:#$_"         # => main:sub
        => ruby 1.6.4 (2001-06-04) [i586-linux]
           sub:sub
           main:main
           sub:sub
           main:sub
        => ruby 1.6.5 (2001-09-19) [i586-linux]
           sub:sub
           main:main
           sub:sub
           main:main

: net/telnet

  Net::Telnet ������Υۥ��Ȥ���³�塢ư���ʤ���������ޤ�����
  ((<ruby-list:31303>))

: CGI#header

  �ʲ��Τ褦�ʥ�����ץȤ�TEXT_PLAIN��"text/plain; charset=iso-8859-1"
  �Τ褦�˽񤭴������Ƥ��ޤ�����
  ((<ruby-dev:14716>))

        require 'cgi'

        TEXT_PLAIN = "text/plain"

        cgi = CGI.new
        print cgi.header("type" => TEXT_PLAIN,
                         "charset" => "iso-8859-1")
        printf("TEXT_PLAIN: %s\n", TEXT_PLAIN)

        => ruby 1.6.4 (2001-06-04) [i586-linux]
           Content-Type: text/plain; charset=iso-8859-1
           ^M
           TEXT_PLAIN: text/plain; charset=iso-8859-1
           TEXT_PLAIN: text/plain

        => ruby 1.6.5 (2001-09-19) [i586-linux]
           Content-Type: text/plain; charset=iso-8859-1
           ^M
           TEXT_PLAIN: text/plain

: Dir.chdir

        �Ķ��ѿ� HOME, LOGDIR �Τ�������������Ƥ��ʤ��Ȥ������ʤ��� 
        Dir.chdir �� ArgumentError �㳰�򵯤����褦�ˤʤ�ޤ���

        ENV['HOME'] = nil
        ENV['LOGDIR'] = nil
        Dir.chdir
        => -:3:in `chdir': Bad address (Errno::EFAULT)
                from -:3
           ruby 1.6.4 (2001-08-26) [i586-linux]
        => -:3:in `chdir': HOME/LOGDIR not set (ArgumentError)
                from -:3
           ruby 1.6.5 (2001-09-19) [i586-linux]

: Dir.glob

  �ʲ��Υ����ɤ�̵�¥롼�פˤʤäƤ��ޤ�����

        Dir.mkdir("test?") rescue nil
        p Dir.glob("test?/*")
        => ruby 1.6.5 (2001-09-19) [i586-linux]
           []

: jcode
  �Х��������Ĥ���������ޤ�����((<ruby-list:31238>))


�����δ֡�������֡�

: ((<Dir>)).glob

  Dir.glob("*/**/*")�����֥ǥ��쥯�ȥ�Υե�����������֤��Ƥ��ޤ�����
  ((<ruby-dev:14576>))

    Dir.mkdir('foo') rescue nil
    Dir.mkdir('foo/bar') rescue nil
    p Dir.glob('*/**/*')

    => ruby 1.6.4 (2001-06-04) [i586-linux]
       ["foo/bar", "foo/bar"]

    => ruby 1.6.4 (2001-08-26) [i586-linux]
       ["foo/bar"]

: ((<UnboundMethod>))#bind

  �⥸�塼��� UnboundMethod ���֥������Ȥ� bind ���뤳�Ȥ��Ǥ��ޤ���Ǥ�����
  ((<rubyist:0728>))

    module Foo
      def foo
        :foo
      end
    end

    class Bar
      include Foo
    end

    m = Foo.instance_method :foo
    p m.bind(Bar.new).call

    => ruby 1.6.4 (2001-06-04) [i586-linux]
       -:12:in `bind': first argument must be an instance of Foo (TypeError)
            from -:12

    => ruby 1.6.4 (2001-08-23) [i586-linux]
       :foo

: �Ȥ߹��ߥ��饹���֤�����

  �Ȥ߹��ߥ��饹���⥸�塼��(�������������)�ؤ�������Ԥä��Ȥ��˷ٹ��
  �Ф��褦�ˤʤ�ޤ�����

    Array = nil
    p Array
    => ruby 1.6.4 (2001-06-04) [i586-linux]
       nil

    => -:1: warning: already initialized constant Array
       ruby 1.6.4 (2001-08-23) [i586-linux]
       nil

: ((<Regexp>))

  ��̤ο�����礭�ʿ��ΥХå���ե���󥹤����ˤǤ�ޥå����Ƥ��ޤ�����
  ((<ruby-list:30975>))

    p /(foo)\2/ =~ "foobar"
    => ruby 1.6.4 (2001-06-04) [i586-linux]
       0
    => ruby 1.6.4 (2001-08-23) [i586-linux]
       nil

: ((<TCPSocket>)).open

  ((<Cygwin>)) �� ((<TCPSocket>)).open �������ߥ󥰤ˤ�äƥ��顼(Errno::EINVAL,
  EALREADY)�ˤʤ뤳�Ȥ�����������н褷�ޤ�����(1.6.4 20010712�ʹ�)
  ((<ruby-talk:9939>)), ((<ruby-talk:16632>)),
  ((<ruby-list:24702>)), ((<ruby-list:27805>)), ((<ruby-list:30512>)) ���ʤ�

: resolv, resolv-replace

  �ɲá�ruby�Ǽ��������꥾���(DNS��̾�����) ��Socket��Ϣ�Υ��饹�Ǥ�
  �Υ饤�֥�����Ѥ��뤿��Υ饤�֥��Ǥ���

  ruby�Ǽ��������꥾��Фϡ�timeout �����椬�����ޤ�(�Ĥޤꡢ̾����
  �����Thread�����ؤ���ǽ�Ȥ������ȤǤ�)

    require 'resolv'
    p Resolv.new.getaddress("www.ruby-lang.org").to_s

    => /usr/local/lib/ruby/1.6/resolv.rb:160: warning: timeout (...) interpreted as method call
       /usr/local/lib/ruby/1.6/resolv.rb:55: warning: instance variable @initialized not initialized
       /usr/local/lib/ruby/1.6/resolv.rb:113: warning: instance variable @initialized not initialized
       /usr/local/lib/ruby/1.6/resolv.rb:392: warning: instance variable @initialized not initialized
       ruby 1.6.4 (2001-08-23) [i586-linux]
       "210.251.121.214"

: ((<Digest|digest>)) �⥸�塼��

  SHA1, MD5 �� Digest::SHA1, Digest::MD5 ���֤��������ޤ�����
  Digest::SHA256, Digest::SHA384,  Digest::SHA512, Digest::RMD160
  �⿷�����ɲä���ޤ�����

    require 'digest/md5'
    include Digest

    md = MD5.new
    md << "abc"
    puts md

    puts MD5.hexdigest("123")

: ((<Struct>))

  �ե꡼�����줿��¤�Υ��֥������Ȥ��ѹ��Ǥ��Ƥ��ޤ������ޤ���$SAFE =
  4 �ΤȤ����ѹ���ػߤ���褦�ˤ��ޤ�����((<ruby-talk:19167>))

    cat = Struct.new("Cat", :name, :age, :life)
    a = cat.new("cat", 12, 7).freeze
    a.name = "dog"
    p a
    => ruby 1.6.4 (2001-06-04) [i586-linux]
       #<Struct::Cat name="dog", age=12, life=7>
    => ruby 1.6.4 (2001-08-06) [i586-linux]
       -:4:in `name=': can't modify frozen Struct (TypeError)
            from -:4

    cat = Struct.new("Cat", :name, :age, :life)
    a = cat.new("cat", 12, 7)
    Thread.new do
       abort_on_exception = true
       $SAFE = 4
       a.life -= 1
    end.join
    p a.life
    => ruby 1.6.4 (2001-06-04) [i586-linux]
       6
    => ruby 1.6.4 (2001-08-06) [i586-linux]
       -:6:in `life=': Insecure: can't modify Struct (SecurityError)
            from -:3:in `join'
            from -:3

: ((<String>))#rindex

  rindex ������ɽ�����Ϥ����Ȥ���ư��˥Х�������ޤ�����((<ruby-dev:13843>))
  (1.6.4 ��꡼����ΥХ��Ǥ�)

    p "foobar".rindex(/b/)
    => ruby 1.6.4 (2001-06-04) [i586-linux]
       3

    => ruby 1.6.4 (2001-06-19) [i386-freebsd5.0]
       nil

    => ruby 1.6.4 (2001-08-06) [i586-linux]
       3

: ((<require|�Ȥ߹��ߴؿ�>))

  require�� ~ �ǻϤޤ�ե�����̾����ꤷ���Ȥ�����ĥ�Ҥ��Ĥ��Ƥ�
  ���ȥ����ɤǤ��ʤ��ʤäƤ��ޤ�����((<ruby-dev:13756>))

    $ echo p __FILE__ > ~/a.rb
    $ ruby17 -v -r~/a -e0
    ruby 1.7.1 (2001-07-03) [i686-linux]
    0: No such file to load -- ~/a (LoadError)
    $ ruby16 -v -r~/a -e0
    ruby 1.6.4 (2001-07-02) [i686-linux]
    0: No such file to load -- ~/a (LoadError)
    $ ruby14 -v -r~/a -e0
    ruby 1.4.6 (2000-08-16) [i686-linux]
    "/home/nobu/a.rb"

: ((<String>))#each_line

  ���������������¤��Ƥ��ޤ���Ǥ�����((<ruby-dev:13755>))

    "foo\nbar\n".taint.each_line {|v| p v.tainted?}
    => ruby 1.6.4 (2001-06-04) [i586-linux]
       false
       true
    => ruby 1.6.4 (2001-08-06) [i586-linux]
       true
       true

: ((<NKF|nkf>)).nkf

  ���������������¤��Ƥ��ޤ���Ǥ�����((<ruby-dev:13754>))

    require 'nkf'
    p NKF.nkf("-j", "a".taint).tainted?

    => ruby 1.6.4 (2001-06-04) [i586-linux]
       false
    => ruby 1.6.4 (2001-08-06) [i586-linux]
       true

: ruby -x

  ���ץ���� ((<Ruby�ε�ư/-x[directory]>)) ����ꤷ���Ȥ��˥�����
  �ץȤ�¹Ԥ����˽�λ���뤳�Ȥ�����ޤ�����((<ruby-dev:13752>))

: attr_*

  ����������;�פʰ������Ϥ��Ƥ⥨�顼�ˤʤ�ޤ���Ǥ�����
  ((<ruby-dev:13748>))

    class C
      def initialize
        @message = 'ok'
      end
      attr_reader :message
    end
    puts C.new.message(1,2,3)

    => ruby 1.6.4 (2001-06-04) [i586-linux]
       ok
    => ruby 1.6.4 (2001-08-06) [i586-linux]
       -:7:in `message': wrong # of arguments(3 for 0) (ArgumentError)
            from -:7

: ((<Readline|readline>)).completion_append_character
: ((<Readline|readline>)).completion_append_character=

  �ɲá�GNU Readline �饤�֥����ѿ� (({rl_completion_append_character}))
  �Υ���������(�����ѿ��� GNU readline 2.1 �ʹߤǻȤ��ޤ�)
  ((<ruby-ext:01760>))

: ((<Socket::Constants>))

  �����åȴ�Ϣ������Τ����ʲ����������ɲä���ޤ���(�����ƥ�������
  ��Ƥ�����˸¤�)��

    SO_PASSCRED
    SO_PEERCRED
    SO_RCVLOWAT
    SO_SNDLOWAT
    SO_RCVTIMEO
    SO_SNDTIMEO
    SO_SECURITY_AUTHENTICATION
    SO_SECURITY_ENCRYPTION_TRANSPORT
    SO_SECURITY_ENCRYPTION_NETWORK
    SO_BINDTODEVICE
    SO_ATTACH_FILTER
    SO_DETACH_FILTER
    SO_PEERNAME
    SO_TIMESTAMP

: ((<require|�Ȥ߹��ߴؿ�>)) / $LOAD_PATH

  Changed to use a new algorithm to locate a library.

  Now when requiring "foo", the following directories are searched for
  the library in the order listed.

    $prefix/lib/ruby/site_ruby/$ver/foo.rb
    $prefix/lib/ruby/site_ruby/$ver/foo.so
    $prefix/lib/ruby/site_ruby/$ver/$arch/foo.rb
    $prefix/lib/ruby/site_ruby/$ver/$arch/foo.so
    $prefix/lib/ruby/site_ruby/foo.rb
    $prefix/lib/ruby/site_ruby/foo.so
    $prefix/lib/ruby/$ver/foo.rb
    $prefix/lib/ruby/$ver/foo.so
    $prefix/lib/ruby/$ver/$arch/foo.rb
    $prefix/lib/ruby/$ver/$arch/foo.so
    ./foo.rb
    ./foo.so

  The previous behavior had a potential security risk because a
  foo.rb (if exists) in the current directory is located prior to a
  foo.so in $prefix/lib/ruby/site_ruby/$ver/$arch.

  ((<ruby-bugs:PR#140>)), ((<ruby-ext:01778>)), ((<ruby-dev:13659>))

: sync
: mutex_m

  Fixed for obj.extend(Sync_m) and obj.extend(Mutex_m).((<ruby-dev:13463>))

    $ ruby -v -rsocket -rmutex_m -e 's=TCPSocket.new("localhost",25); s.extend(Mutex_m)'
    ruby 1.6.4 (2001-06-04) [i386-linux]
    /usr/lib/ruby/1.6/mutex_m.rb:104:in `initialize': wrong # of arguments (0 for 1) (ArgumentError)
            from /usr/lib/ruby/1.6/mutex_m.rb:104:in `initialize'
            from /usr/lib/ruby/1.6/mutex_m.rb:50:in `mu_extended'
            from /usr/lib/ruby/1.6/mutex_m.rb:34:in `extend_object'
            from -e:1:in `extend'
            from -e:1

: $SAFE / ((<load|�Ȥ߹��ߴؿ�>))

  1 <= $SAFE <= 3 �ǡ���������� true �ΤȤ��������줿�ե�����̾��
  ���ꤷ�Ƥ� load() �Ǥ��Ƥ��ޤ��Х�����������ޤ�����((<ruby-dev:13481>))

    $SAFE = 1
    filename = "foo"
    filename.taint
    p load(filename, true)

    => ruby 1.6.4 (2001-06-04) [i586-linux]
       true

    => ruby 1.6.4 (2001-08-06) [i586-linux]
       -:4:in `load': Insecure operation - load (SecurityError)
            from -:4

: ((<Regexp>))

  �ʲ��ǡ����Ԥ��ޥå����ޤ���Ǥ�����((<ruby-talk:16233>))

    puts "OK 1" if /(.|a)bd/ =~ "cxbd"
    puts "OK 2" if /(a|.)bd/ =~ "cxbd"

    => ruby 1.6.4 (2001-06-04) [i586-linux]
       OK 2
    => ruby 1.6.4 (2001-08-06) [i586-linux]
       OK 1
       OK 2

: ((<Marshal>))

  �⥸�塼��Υ����ɤη������å��˸��꤬����ޤ����������ѹ��ˤ��dump
  �ե����ޥåȤΥޥ��ʡ��С������1������ޤ���

    p Marshal.dump(Object.new).unpack("CC").join(".")
        => ruby 1.6.4 (2001-06-04) [i586-linux]
           "4.5"
    p Marshal.dump(Object.new).unpack("CC").join(".")
        => ruby 1.6.4 (2001-06-11) [i586-linux]
           "4.6"

: $SAFE / ((<���饹���᥽�åɤ����/def>))

  doc/NEWS �ˤ�

    Fixed so defining a new method is allowed under $SAFE == 4, which
    previously wasn't.

  �Ȥ��뤱�ɼºݤˤϤǤ��ޤ���

    $SAFE = 4; def a; end

    => -:1: Insecure operation `(null)' at level 4 (SecurityError)
       ruby 1.6.4 (2001-06-04) [i586-linux]

    => -:1: Insecure: can't define method (SecurityError)
       ruby 1.6.4 (2001-08-06) [i586-linux]

  �б�����ChangeLog�ϰʲ��Τ褦�Ǥ���

    Tue Jun  5 15:16:06 2001  Yukihiro Matsumoto  <matz@ruby-lang.org>

            * eval.c (rb_add_method): should not call rb_secure(), for
              last_func may not be set.

  ��ʬ�ϰʲ��Τ褦�Ǥ���

    @@ -227,10 +227,7 @@ rb_add_method(klass, mid, node, noex)
         NODE *body;

         if (NIL_P(klass)) klass = rb_cObject;
    -    if (klass == rb_cObject) {
    -       rb_secure(4);
    -    }
    -    if (rb_safe_level() >= 4 && !OBJ_TAINTED(klass)) {
    +    if (rb_safe_level() >= 4 && (klass == rb_cObject || !OBJ_TAINTED(klass))) {
            rb_raise(rb_eSecurityError, "Insecure: can't define method");
         }
         if (OBJ_FROZEN(klass)) rb_error_frozen("class/module");

  �ޤ�����Ĵ��ľ���ޤ���

: ((<IO>))#ioctl

  ��������� Bignum ������դ���褦�ˤʤ�ޤ���(long int ���ϰϤ򥫥С�
  ���뤿��)

== 1.6.3 (2001-03-19) -> 1.6.4 (2001-06-04)

: ((<Hash>))#replace

  �ϥå���Υ��ƥ졼����ˡ����Υϥå���Τ������Ǥ������ơ�
  ¾�Υϥå����replace�����Abort���Ƥ��ޤ�����((<ruby-dev:13432>))

    h  = { 10 => 100, 20 => 200 }
    h2 = { }

    h.each { |k, v|
      if (k == 10)
        h.delete(10)
        h2.replace(h)  # => Abort core dumped
      end
    }

: $SAFE / ((<File>)).unlink

  File.unlink �ϰ�������������Ƥʤ��Ƥ� $SAFE >= 2 �δĶ����Ǥ�
  �ػߤ���褦�ˤʤ�ޤ�����((<ruby-dev:13426>))

    touch foo
    ruby -v -e '$SAFE=2;File.unlink("foo")'

    => ruby 1.6.3 (2001-03-19) [i586-linux]
    => ruby 1.6.4 (2001-06-04) [i586-linux]
       -e:1:in `unlink': Insecure operation `unlink' at level 2 (SecurityError)
               from -e:1

: ((<Object>))#untaint

  ��뤷�����֥������Ȥ��Ф���untaint�Ǥ��ʤ��褦�ˤ��ޤ�����((<ruby-dev:13409>))

    a = Object.new
    a.taint
    a.freeze
    a.untaint

    => ruby 1.6.3 (2001-03-19) [i586-linux]
    => ruby 1.6.4 (2001-06-04) [i586-linux]
       -:4:in `untaint': can't modify frozen object (TypeError)
               from -:4

: ruby -T4

  ���ץ���� ((<-T4|Ruby�ε�ư/-T[level]>)) ����ꤷ���Ȥ���ARGV ��
  �ѹ��Ǥ��ʤ�����ץ������μ¹Ԥ��Ǥ��ޤ���Ǥ�����
  ((<ruby-dev:13401>))

    touch foo
    ruby-1.6.3 -v -T4 foo
    => ruby 1.6.3 (2001-03-19) [i586-linux]
       foo: Insecure: can't modify array (SecurityError)

: ((<Regexp>))

  ����ɽ����� \1 .. \9 �Ͼ�˥Хå���ե���󥹤Ȥ��Ʋ�ᤵ���褦��
  �ʤ�ޤ���(�������б������̤�����ХХå���ե���󥹡��ʤ����8��
  ��ʸ�������ɤȤ��Ʋ�ᤵ��Ƥ��ޤ���)��

  ����ɽ����8��ʸ�������ɤ���ꤹ��ˤ� \001 �Τ褦��3��ǻ��ꤷ�ޤ���

  �ޤ����б������̤Τʤ��Хå���ե���󥹤��б������̤����Ȥ�ޤ�
  �Хå���ե���󥹤Ͼ�˥ޥå��˼��Ԥ���褦�ˤʤ�ޤ�����

    p /(foo)\2/ =~ "foo\002"
    => ruby 1.6.3 (2001-03-19) [i586-linux]
       0
    => ruby 1.6.4 (2001-06-04) [i586-linux]
       0
    => ruby 1.6.4 (2001-08-23) [i586-linux]
       nil

  (�嵭���̤� 1.6.4 �ˤϤޤ��Х�������ޤ��� 2001-08-23 ������ǽ�����
  ��Ƥ��ޤ� ((<ruby-list:30975>)))

    p /(foo\1)/ =~ "foo"
    => ruby 1.6.3 (2001-03-19) [i586-linux]
       0
    => ruby 1.6.4 (2001-06-04) [i586-linux]
       nil

: ����ʸ���������

  �ʲ��ϡ����٤� true ���֤��褦�ˤʤ�ޤ�����((<ruby-dev:13340>))

    # []=
    s1 = "abc"
    s2 = "cde".taint
    s1[0]= s2
    p s1.tainted?             # => false

    # crypt
    s = "abc".taint
    p s.crypt("cd").tainted?  # => false

    # ljust
    s = "abc".taint
    p s.ljust(10).tainted?    # => false

    # rjust
    s = "abc".taint
    p s.rjust(10).tainted?    # => false

    # center
    s = "abc".taint
    p s.center(10).tainted?   # => false

: rb_yield_0()

  C API ���� yield ���줿�Ȥ� 1 �Ĥΰ����� 1 ���Ǥ�����Ȥ����Ϥ���Ƥ��ޤ�����
  ((<ruby-dev:13299>))

    class X
      include Enumerable

      def each(&block)
        block.call(1,2)
        block.call(2,3)
        block.call(3,4)
      end
    end

    x = X.new
    p x.to_a #=> [[1], [2], [3]]

    # => ruby 1.6.3 (2001-03-19) [i586-linux]
         [[1], [2], [3]]

    # => ruby 1.6.4 (2001-06-04) [i586-linux]
         [1, 2, 3]

: $SAFE / alias

  $SAFE = 4 �ΤȤ��������Х��ѿ��Υ����ꥢ��������ʤ��褦�ˤ��ޤ�����
  ((<ruby-dev:13287>))

: ((<open3/Open3.popen3>))

  ��λ�����ץ������� at_exit ��ƤФʤ��褦�ˤ��ޤ�����
  (exit �� exit! �˽���) ((<ruby-dev:13170>))

: ((<SizedQueue>))#pop

  �ʲ��Υ����ɤǥǥåɥ��å���������ʤ��褦�ˤ��ޤ�����((<ruby-dev:13169>))

    ruby -r thread -e 'q = SizedQueue.new(1); q.push(1);'\
                   -e 'Thread.new{sleep 1; q.pop}; q.push(1);'

: ((<SizedQueue>))#max=

  max�������ͤ���礭�����ˤ��κ���ʬ�����Ԥ�����åɤ򵯤�������
  ��Ƚ��˸��꤬����ޤ�����((<ruby-dev:13170>))

: ((<Queue>))
: ((<SizedQueue>))

  ((<Thread>))#run ��Ƥ�ľ���˥���åɤ����Ǥ������� ((<ThreadError>))
  ��ȯ������������н褷�ޤ�����((<ruby-dev:13194>))

: Ctrl-C (Interrupt)�������ʤ��ʤ�

  ((<ruby-dev:13195>))

    th1 = Thread.start {
      begin
        Thread.stop
      ensure
        Thread.pass
        Thread.stop
      end
    }
    sleep 1

  (��ǧ�Ǥ���¤�Ǥ� ruby-1.7.0 (2001-05-17) �ʹߤǼ��äƤޤ�����
  1.6 �ˤϼ����ޤ�Ƥ��ޤ���)

: ((<Array>))#&
: ((<Array>))#|
: ((<Array>))#uniq

  ��̤���������Ǥ� freeze �����ѹ��ԲĤˤʤäƤ��ޤ�����((<ruby-list:29665>))

    (%w(foo bar) & %w(foo baz))[0].upcase!
    => -:1:in `upcase!': can't modify frozen string (TypeError)

    %w(foo bar bar baz).uniq[0].upcase!
    => -:1:in `upcase!': can't modify frozen string (TypeError)

: ((<shell>))

    shell 0.6 ��ɸ��饤�֥��Ȥ��ƿ������ɲä���ޤ�����
    (�ɥ�����Ȥ� doc �ǥ��쥯�ȥ�ˤ���ޤ�)

: ((<forwardable>))

    forwardable 1.1 ��ɸ��饤�֥��Ȥ��ƿ������ɲä���ޤ�����
    (�ɥ�����Ȥ� doc �ǥ��쥯�ȥ�ˤ���ޤ�)

: ((<irb>)) & irb-tools

    irb �� irb-tools �����줾�� 0.7.4 �� 0.7.1 �˥С�����󥢥åפ��ޤ�����

: �ƻ���

  �ƻ��֤ι�θ������������ޤ���(��) ((<ruby-bugs-ja:PR#46>))

    env TZ=America/Managua ruby -e 'p Time.local(1998,12,1,0,59,59)'
    => Mon Nov 30 01:59:59 EST 1998
    env TZ=America/Managua ruby -e 'p Time.local(1998,12,1,0,59,59).tv_sec'   
    => 912409199

: SIGINFO

  4.4BSD �Υ����ʥ� SIGINFO ���б����ޤ�����((<ruby-bugs-ja:PR#45>))

: ((<Thread>)).stop �� SEGV

  ((<Thread>)).stop �� SEGV ���뤳�Ȥ�����ޤ�����((<ruby-dev:13189>))

: rescue ����

  �ʲ��� 1.6.3 �� parse error �ˤʤäƤ����Х�����������ޤ�����
  ((<ruby-dev:13073>)), ((<ruby-dev:13292>))

    raise "" rescue []
    raise "" rescue (p "foo"; true)
    raise "" rescue -1
    raise "" rescue (-1)

: ((<Thread>))

  �ʲ��� dead lock �ˤʤ�ʤ��ʤ�ޤ�����

    Thread.start { Thread.stop }
    sleep

    => deadlock 0x40199b58: 2:0  - -:1
       deadlock 0x401a2528: 2:4 (main) - -:2
       -:2:in `sleep': Thread: deadlock (fatal)
               from -:2
       ruby 1.6.3 (2001-03-19) [i586-linux]

: ((<Module>))#const_defined?
: ((<Module>))#const_get
: ((<Module>))#const_set

  �����Υ᥽�åɤ�����ʳ��˥���������ǽ�ˤʤäƤ����Х�����������ޤ���
  ((<ruby-dev:13019>))

: ((<Marshal>)).dump

  ((<Float>)) �� dump ����Ȥ������٤� "%.12g" ���� "%.16g" �ˤʤ�ޤ�����
  ((<ruby-list:29349>))

: ((<Fixnum>))#[]

  sizeof(long) > sizeof(int) �ʥ����ƥ�ǤΥХ����������줿�褦�Ǥ���

: ����ɽ��

  �ޤ�ʥХ���2�､������ޤ��� ((<ruby-talk:13658>)), ((<ruby-talk:13744>))

: retry

  �ʲ��� 1.6.3 ������˵�ǽ���ޤ���Ǥ���((<ruby-talk:13957>))

        def WHILE(cond)
          return if not cond
          yield
          retry
        end

        i=0
        WHILE(i<3) {
          print i
          i+=1
        }

        ruby 1.6.2 (2000-12-25) [i586-linux]
        => 012

        ruby 1.6.3 (2001-03-19) [i586-linux]
        => 0

        ruby 1.6.4 (2001-05-02) [i586-linux]
        => 012

: ((<File::Stat>))#size

  1G byte �ʾ�Υե�������Ф����������ե����륵�������֤��Ƥ��ޤ���Ǥ�����

        File.open("/tmp/1GB", "w") {|f|
          f.seek(2**30-1, 0)
          f.puts
          f.flush
          p f.stat.size
        }

        # => ruby 1.6.3 (2001-04-03) [i586-linux]
             -1073741824
        # => ruby 1.6.4 (2001-04-19) [i586-linux]
             1073741824

: ((<Float>))#modulo, ((<Float>))#divmod

  �ʤ󤫽������줿�ߤ����Ǥ� ((<ruby-dev:12718>))

: ((<ObjectSpace>))#_id2ref

  �������㳰���֤���礬����ޤ�����

: malloc �κƵ��ƤӽФ�����

  stdio �������� malloc() ��ƤӽФ���硢Thread �������������ä����Ȥ���
  �褷�ޤ�����(setvbuf() ����Ѥ��뤳�Ȥ� malloc() ���ƤФ��Τ��򤱤�)
  ((<ruby-dev:12795>))

: ((<File>))#flock

  File#flock �����å��Ѥߤξ��� false ���֤��� Errno::EACCES �㳰��
  �������礬����ޤ���(flock()���ʤ������ƥ�ξ��)

: ((<File::Stat>)).new(filename)

  �ɲ� ((<ruby-dev:12803>))

: ((<Bignum>))#% �η׻�����

  % �η׻��˸��꤬�Ф뤳�Ȥ�����Х���(����)��������ޤ���

        a = 677330545177305025495135714080
        b = 14269972710765292560
        p a % b  #=> 0
        p -a % b #=> 

        => ruby 1.6.3 (2001-04-02) [i386-cygwin]
           0
           14269972710765292560

        => ruby 1.6.4 (2001-04-19) [i586-linux]
           0
           0

: ((<Marshal>))
  Bignum �� dump -> load ������̤������ͤȰۤʤ��礬����ޤ�����

  ����˴�Ϣ���뽤���� 1.6.3 ��꡼���塢3��ۤɹԤ��Ƥ��ޤ���
  stable-snapshot ��
    ruby 1.6.3 (2001-03-22)
  �ʹߤ���Ѥ��Ƥ���������

: Universal Naming Convention(UNC) �Υ��ݡ���(win32)
  UNC �����Υѥ�̾ (//host/share) �����ݡ��Ȥ���ޤ�����
  �Хå�����å���(`(({\}))')�ǤϤʤ�����å���(`(({/}))')��Ȥ��ޤ���
  (����ȥ��ݡ��Ȥ���Ƥ��Τ��Х��������줿����)

: ((<Dir>)).glob (win32)
  �����ȥǥ��쥯�ȥ�(./)���Ф���glob�����Ԥ��Ƥ��ޤ�����
        p Dir["./*.c"]
        => []

== 1.6.2 -> 1.6.3 (2001-03-19)

: do .. end �� { .. }
  ��綯�٤ΰ㤤���ʤ��ʤäƤ����Х�����������ޤ�����

  1.6.0 ���� 1.6.2 �ޤǤΥС������Ǥϡ�
     method v { .. }
     method v do .. end
  ��ξ�Ԥ˰㤤������ޤ���Ǥ���������ε�ư��((<�᥽�åɸƤӽФ�/���ƥ졼��>))
  �˽񤫤줿�̤�Ǥ���

: ((<Bignum>))#% �η׻�����
  % �η׻��˸��꤬�Ф뤳�Ȥ�����Х�����������ޤ���

    ruby-1.6.2 -ve 'p 6800000000%4000000000'
    => ruby 1.6.2 (2000-12-25) [i586-linux]
       -1494967296

    ruby-1.6.3 -ve 'p 6800000000%4000000000'
    => ruby 1.6.3 (2001-03-10) [i586-linux]
       2800000000

: �ðۥ᥽�å����
  �̾�Υ᥽�å������Ʊ�ͤ� rescue, ensure ��λ��꤬��ǽ�ˤʤ�ޤ���

    obj = Object.new
    def obj.foo
    rescue
    ensure
    end

: ((<String>))#count
: ((<String>))#delete
: ((<String>))#squeeze
: ((<String>))#tr
: ((<String>))#tr_s
  '\-' �� '-' ������ǽ�ˤʤ�ޤ���(tr! ����bang method ��Ʊ��)��
  �����ϡ�ʸ�������Ƭ�ޤ���������'-'������'-'�ȸ��ʤ��Ƥ��ޤ�����

    p "-".tr("a-z",  "+")  # => "-"
    p "-".tr("-az",  "+")  # => "+"
    p "-".tr("az-",  "+")  # => "+"
    p "-".tr('a\-z', "+")  # => "+" # ���󥰥륯������ʸ����Ǥ��뤳�Ȥ�����
    p "-".tr("a\\-z", "+") # => "+" # "" �Ǥ���Ť�\��ɬ��

: ((<Regexp>))#==
  ���٤ƤΥ��ץ�����Ʊ���ʤ��Ʊ����Ƚ�Ǥ���褦�ˤʤ�ޤ�����
  �����ϡ����������ɻ���� /i (case-insensitive) �λ��꤬Ʊ����
  �����Ʊ����Ƚ�Ǥ��Ƥ��ޤ�����

: %q(), %w()
  ��ƥ��ν�λʸ��(`)'�ʤ�)��Хå�����å��奨�������ײ�ǽ�ˤʤ�ޤ�����

: ((<Dir>)).glob
  "**/" ������ܥ�å���󥯤�é��ʤ��ʤ�ޤ�����

: ((<String>))#[]
  "a"[1,2] �� "" ���֤��褦�ˤʤ�ޤ�����

    p "a"[1,2]
    => ""

  ���������ε�ư�Ǥ������ΥС������(1.4.6�ʤ�)�⤳���ͤ��֤��Ƥ��ޤ�����
  1.6.0 �ʹ� 1.6.2 �ޤǤϾ嵭�� (({nil})) �ˤʤ�ޤ���

  (({p "a"[2,1]})) �ϡ�(({nil})) ���֤��ޤ���

: ((<Object>))#taint
  ((<freeze|Object>)) �������֥������Ȥ��Ф��� (({taint})) �Ǥ��ʤ��ʤ�ޤ���

    obj = Object.new.freeze
    obj.taint
    => -:2:in `taint': can't modify frozen object (TypeError)
               from -:2