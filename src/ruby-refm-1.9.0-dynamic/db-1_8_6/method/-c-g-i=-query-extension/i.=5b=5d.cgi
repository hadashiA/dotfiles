visibility=public
kind=defined
names=[]

--- [](key)

ʸ���� key ���б�����ѥ�᡼����������֤��ޤ���
key ���б�����ѥ�᡼�������Ĥ���ʤ��ä����ϡ�nil ���֤��ޤ�����[[m:CGI#params]]�������Ǥ���

�ե����फ�����Ϥ��줿�ͤ䡢URL �������ޤ줿 QUERY_STRING �Υѡ�����̤μ����ʤɤ˻��Ѥ��ޤ���

((<ruby 1.8 feature>)): ��ư�� 1.6 ������ cgi ���礭���Ѳ����Ƥ��ޤ� ((- ���ε�ư��ήưŪ�ǡ�1.8.0, 1.8.1, 1.8.2 �ε�ư�Ϥ��٤ưۤʤ�ޤ���1.9.0�ε�ư��1.8.2��Ʊ�ͤǤ��ˡ� -)) ���᥽�åɤ��֤��ͤ�����Ǥʤ���ʸ���� ((- 1.8.1 �ޤǤϡ����Τ˸����� String �ǤϤ���ޤ��� -)) �ˤʤꡢ�����ȼ�ä� cgi[key][0] �Τ褦�ʽ������ѻߤ���ޤ������ޤ� key ���б�����ѥ�᡼����¸�ߤ��ʤ��ä���硢nil �ǤϤʤ� "" ���֤��褦�ˤʤäƤ��ޤ��� ruby 1.6 ��Ʊ����ư��˾����ϡ�[[m:CGI#params]]�����Ѥ��Ƥ���������

���η�̡����󥿡��ե��������ɤ��Ѥ�ä��Τ��ˤĤ��Ƥϡ��ʲ�����򻲹ͤˤ��Ƥ���������

      # with ruby 1.6 ---------------------------
      cgi = CGI.new
      cgi['developer']     # => ["Matz"] (Array)
      cgi['developer'][0]  # => "Matz" (String)
      cgi['']              # => nil

      # with ruby 1.8 ---------------------------
      cgi = CGI.new
      cgi['developer']     # => "Matz"
      cgi['developer'][0]  # => obsolete�ʷٹ𤬽Фޤ���
      cgi['']              # => ""

cgi['developer'].is_a?(String) # => 1.8.1�ޤǤ�false��1.8.2�ʹߤ�true

    [[unknown:��ɮ���罸]]
