�ƥ�ݥ��ǥ��쥯�ȥ�Τ���Υ饤�֥��Ǥ���

= reopen Dir

== Class Methods

#@since 1.8.7
--- mktmpdir(prefix_suffix = nil, tmpdir = nil)             -> String
--- mktmpdir(prefix_suffix = nil, tmpdir = nil){|dir| ... } -> object

����ǥ��쥯�ȥ��������ޤ���

�������줿�ǥ��쥯�ȥ�Υѡ��ߥå����� 0700 �Ǥ���

�֥��å���Ϳ����줿���ϡ��֥��å���ɾ����������
�������줿����ǥ��쥯�ȥ�䤽���۲��ˤ��ä��ե������
[[m:FileUtils.#remove_entry_secure]] ���Ѥ��ƺ�����ޤ���
�֥��å���Ϳ�����ʤ��ä����ϡ�������������ǥ��쥯�ȥ�Υѥ���
�֤��ޤ������ξ�硢���Υ᥽�åɤϺ�����������ǥ��쥯�ȥ�������ޤ���

@param prefix_suffix nil �ξ��ϡ�'d' ��ǥե���ȤΥץ�ե������Ȥ��ƻ��Ѥ��ޤ������ե��å������դ��ޤ���
                     ʸ����Ϳ����줿���ϡ�����ʸ�����ץ�ե������Ȥ��ƻ��Ѥ��ޤ������ե��å������դ��ޤ���
                     2 ���Ǥ�����Ϳ����줿���ϡ�����ܤ����Ǥ�ץ�ե�����������ܤ����Ǥ򥵥ե��å����Ȥ��ƻ��Ѥ��ޤ���

@param tmpdir nil �ξ��� [[m:Dir.tmpdir]] ����Ѥ��ޤ���
              �����Ǥʤ����ϡ����Υǥ��쥯�ȥ����Ѥ��ޤ���


������
  require 'tmpdir'

  puts Dir.tmpdir
  # ������: ư��Ķ��ˤ����Ϥϰۤʤ�ޤ���
  #=> /cygdrive/c/DOCUME~1/kouya/LOCALS~1/Temp
  Dir.mktmpdir{|dir| 
    puts dir
    # ������: ����ǥ��쥯�ȥ� ��̾������Ƭ��'d' ��Ĥ��롣
    #=> /cygdrive/c/DOCUME~1/kouya/LOCALS~1/Temp/d20081011-4524-1m69psi
    #                                            ^                    
  }
  Dir.mktmpdir("foo"){|dir|
    puts dir
    # ������:����ǥ��쥯�ȥ� ��̾������Ƭ��'foo' ��Ĥ��롣
    #=> /cygdrive/c/DOCUME~1/kouya/LOCALS~1/Temp/foo20081011-4824-pjvhwx
    #                                            ^^^                    
  }
  Dir.mktmpdir(["foo", "bar"]){|dir| 
    puts dir
    # ������: ����ǥ��쥯�ȥ��̾������Ƭ��'foo' ���Ǹ��'bar'��Ĥ��롣
    #=> /cygdrive/c/DOCUME~1/kouya/LOCALS~1/Temp/foo20081011-5624-1hyxrqbbar
    #                                            ^^^                     ^^^
  }
  
  Dir.mktmpdir(nil, "/var/tmp") {|dir|
    puts dir
    # ������: tmpdir �κ����褬'/var/tmp'�Ȥʤ롣
    #         ����ˡ�����ǥ��쥯�ȥ� ��̾������Ƭ��'d' ��Ĥ��롣
    #=> /var/tmp/d20081011-5304-h6b13j
  }
  
  memory_dir = nil
  Dir.mktmpdir {|dir|
    memory_dir = dir
    File.open("#{dir}/foo", "w") { |fp|
     fp.puts "hogehoge"
    }
  }
  # �֥��å���ȴ�����顢�ƥ�ݥ��ǥ��쥯�ȥ�Ͼä���롣
  p FileTest.directory?(memory_dir) #=> false
  
  dir = Dir.mktmpdir
  # �֥��å���Ϳ���ʤ����ϡ��ǥ��쥯�ȥ��¸�ߤ��롣
  begin
    File.open("#{dir}/foo", "w") { |fp|
      fp.puts "hogehoge"
    }
  ensure
    FileUtils.remove_entry_secure dir
  end
  p FileTest.directory?(dir) #=> false


#@end

--- tmpdir    -> String

�ƥ�ݥ��ե�������������Τ˻Ȥ��ǥ��쥯�ȥ�(�ƥ�ݥ��ǥ��쥯�ȥ�)�����Хѥ���
ʸ����Ȥ����֤��ޤ���
[[m:$SAFE]] �ˤ�ä��֤�ʸ������Ѥ��ޤ���

  # WindowsXP�ξ��

  require "tmpdir"

  p Dir.tmpdir #=> "C:/DOCUME~1/taro3/LOCALS~1/Temp"
  $SAFE = 1
  p Dir.tmpdir #=> "C:/WINDOWS/temp"
  $SAFE = 2
  p Dir.tmpdir #=> "C:/WINDOWS/temp"
  $SAFE = 3
  p Dir.tmpdir #=> "C:/WINDOWS/temp"

  # Linux�ξ�� /tmp �˲ä����Ķ��ѿ� ENV['TMPDIR'], ENV['TMP'], ENV['TEMP'], ENV['USERPROFILE']�򻲾Ȥ��ޤ�
  
