#
# bitclust/rdcompiler.rb
#
# Copyright (C) 2006-2007 Minero Aoki
#
# This program is free software.
# You can distribute/modify this program under the Ruby License.
#

require 'bitclust/lineinput'
require 'bitclust/htmlutils'
require 'bitclust/textutils'
require 'stringio'

module BitClust

  class RDCompiler

    include HTMLUtils
    include TextUtils

    def initialize(urlmapper, hlevel = 1, opt = {})
      @urlmapper = urlmapper
      @hlevel = hlevel
      @type = nil
      @library = nil
      @class = nil
      @method = nil
      @option = opt.dup
    end

    def compile(src)
      setup(src) {
        library_file
      }
    end

    def compile_method(m)
      @type = :method
      @method = m
      setup(m.source) {
        method_entry
      }
    end

    private

    def setup(src)
      @f = LineInput.new(StringIO.new(src))
      @out = StringIO.new
      yield
      @out.string
    end

    def library_file
      while @f.next?
        case @f.peek
        when /\A---/
          method_entry_chunk
        when /\A=+/
          headline @f.gets
        when /\A\s+\*\s/
          ulist
        when /\A\s+\(\d+\)\s/
          olist
        when %r<\A//emlist\{>
          emlist
        when /\A:\s/
          dlist
        when /\A\s+\S/
          list
        else
          if @f.peek.strip.empty?
            @f.gets
          else
            paragraph
          end
        end
      end
    end

    def method_entry
      while @f.next?
        method_entry_chunk
      end
    end

    def method_entry_chunk
      @f.while_match(/\A---/) do |line|
        method_signature line
      end
      props = {}
      @f.while_match(/\A:/) do |line|
        k, v = line.sub(/\A:/, '').split(':', 2)
        props[k.strip] = v.strip
      end
      @out.puts '<dd>'
      while @f.next?
        case @f.peek
        when /\A===+/
          headline @f.gets
        when /\A==?/
          if @option[:force]
            break
          else
            raise "method entry includes headline: #{@f.peek.inspect}"
          end
        when /\A---/
          break
        when /\A\s+\*\s/
          ulist
        when /\A\s+\(\d+\)\s/
          olist
        when /\A:\s/
          dlist
        when %r<\A//emlist\{>
          emlist
        when /\A\s+\S/
          list
        when /\A@[a-z]/
          method_info
        else
          if @f.peek.strip.empty?
            @f.gets
          else
            method_entry_paragraph
          end
        end
      end
      @out.puts '</dd>'
      @out.puts '</dl>' if @option[:force]
    end

    def headline(line)
      level = @hlevel + (line.slice(/\A=+/).size - 3)
      label = line.sub(/\A=+/, '').strip
      line h(level, escape_html(label))
    end

    def h(level, label)
      "<h#{level}>#{label}</h#{level}>"
    end

    def ulist
      @out.puts '<ul>'
      @f.while_match(/\A\s+\*\s/) do |line|
        string '<li>'
        string compile_text(line.sub(/\A\s+\*/, '').strip)
        @f.while_match(/\A\s+[^\*\s]/) do |cont|
          nl
          string compile_text(cont.strip)
        end
        line '</li>'
      end
      line '</ul>'
    end

    def olist
      @out.puts '<ol>'
      @f.while_match(/\A\s+\(\d+\)/) do |line|
        string '<li>'
        string compile_text(line.sub(/\A\s+\(\d+\)/, '').strip)
        @f.while_match(/\A\s+(?!\(\d+\))\S/) do |cont|
          string "\n"
          string compile_text(cont.strip)
        end
        line '</li>'
      end
      line '</ol>'
    end

    def dlist
      line '<dl>'
      while @f.next? and /\A:/ =~ @f.peek
        @f.while_match(/\A:/) do |line|
          line dt(compile_text(line.sub(/\A:/, '').strip))
        end
        line '<dd>'
        # FIXME: allow nested pre??
        @f.while_match(/\A(?:\s|\z)/) do |line|
          line compile_text(line.strip)
        end
        line '</dd>'
      end
      line '</dl>'
    end

    def dt(s)
      "<dt>#{s}</dt>"
    end

    def emlist
      @f.gets   # discard "//emlist{"
      line '<pre>'
      @f.until_terminator(%r<\A//\}>) do |line|
        line escape_html(line.rstrip)
      end
      line '</pre>'
    end

    def list
      lines = unindent_block(canonicalize(@f.break(/\A\S/)))
      while lines.last.empty?
        lines.pop
      end
      line '<pre>'
      lines.each do |line|
        line escape_html(line)
      end
      line '</pre>'
    end

    def canonicalize(lines)
      lines.map {|line| detab(line.rstrip) }
    end

    def paragraph
      line '<p>'
      read_paragraph(@f).each do |line|
        line compile_text(line.strip)
      end
      line '</p>'
    end

    def read_paragraph(f)
      f.span(%r<\A(?!---|=|//\w)\S>)
    end

    # FIXME: temporary implementation
    def method_info
      header = @f.gets
      cmd = header.slice!(/\A\@\w+/)
      body = [header] + @f.span(/\A\s+\S/)
      case cmd
      when '@param', '@arg'
        name = header.slice!(/\A\s*\w+/n) || '?'
        line '<p>'
        line "[PARAM] #{escape_html(name.strip)}:"
        body.each do |line|
          line compile_text(line.strip)
        end
        line '</p>'
      when '@return'
        line '<p>'
        line "[RETURN]"
        body.each do |line|
          line compile_text(line.strip)
        end
        line '</p>'
      when '@raise'
        ex = header.slice!(/\A\s*[\w:]+/n) || '?'
        line '<p>'
        line "[EXCEPTION] #{escape_html(ex.strip)}:"
        body.each do |line|
          line compile_text(line.strip)
        end
        line '</p>'
      when '@see'
        line '<p>'
        line '[SEE_ALSO] ' + body.join('').split(',').map {|ref| compile_text(ref.strip) }.join(",\n")
        line '</p>'
      else
        line '<p>'
        line "[UNKNOWN_META_INFO] #{escape_html(cmd)}:"
        body.each do |line|
          line compile_text(line.strip)
        end
        line '</p>'
      end
    end

    # FIXME: parse @param, @return, ...
    def method_entry_paragraph
      line '<p>'
      read_method_entry_paragraph(@f).each do |line|
        line compile_text(line.strip)
      end
      line '</p>'
    end

    def read_method_entry_paragraph(f)
      f.span(%r<\A(?!---|=|//\w|@[a-z])\S>)
    end

    def method_signature(sig)
      # FIXME: check parameters, types, etc.
      string '<dl>' if @option[:force]
      string '<dt><code>'
      string escape_html(sig.sub(/\A---/, '').strip)
      string '</code>'
      if @method and not @method.defined?
        line %Q( <span class="kindinfo">[#{@method.kind} by #{library_link(@method.library.name)}]</span>)
      end
      line '</dt>'
    end

    BracketLink = /\[\[[!-~]+?(?:\[\] )?\]\]/n
    NeedESC = /[&"<>]/

    def compile_text(str)
      escape_table = HTMLUtils::ESC
      str.gsub(/(#{NeedESC})|(#{BracketLink})/o) {
        if    char = $1 then escape_table[char]
        elsif tok  = $2 then bracket_link(tok[2..-3])
        elsif tok  = $3 then seems_code(tok)
        else
          raise 'must not happen'
        end
      }
    end

    def bracket_link(link)
      type, _arg = link.split(':', 2)
      arg = _arg.rstrip
      case type
      when 'lib'     then protect(link) { library_link(arg) }
      when 'c'       then protect(link) { class_link(arg) }
      when 'm'       then protect(link) { method_link(complete_spec(arg), arg) }
      when 'url'     then direct_url(arg)
      when 'man'     then man_link(arg)
      when 'rfc', 'RFC'
        rfc_link(arg)
      when 'ruby-list', 'ruby-dev', 'ruby-ext', 'ruby-talk', 'ruby-core'
        blade_link(type, arg)
      else
        "[[#{escape_html(link)}]]"
      end
    end

    def protect(src)
      yield
    rescue => err
      %Q(<span class="compileerror">[[compile error: #{escape_html(err.message)}: #{escape_html(src)}]]</span>)
    end

    def direct_url(url)
      %Q(<a href="#{escape_html(url)}">#{escape_html(url)}</a>)
    end

    BLADE_URL = 'http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/%s/%s'

    def blade_link(ml, num)
      url = sprintf(BLADE_URL, ml, num)
      %Q(<a href="#{escape_html(url)}">[#{escape_html("#{ml}:#{num}")}]</a>)
    end

    RFC_URL = 'http://www.ietf.org/rfc/rfc%s.txt'

    def rfc_link(num)
      url = sprintf(RFC_URL, num)
      %Q(<a href="#{escape_html(url)}">[RFC#{escape_html(num)}]</a>)
    end

    opengroup_url = 'http://www.opengroup.org/onlinepubs/009695399'
    MAN_CMD_URL = "#{opengroup_url}/utilities/%s.html"
    MAN_FCN_URL = "#{opengroup_url}/functions/%s.html"

    def man_link(spec)
      m = /(\w+)\(([123])\)/.match(spec) or return escape_html(spec)
      url = sprintf((m[2] == '1' ? MAN_CMD_URL : MAN_FCN_URL), m[1])
      %Q(<a href="#{escape_html(url)}">#{escape_html("#{m[1]}(#{m[2]})")}</a>)
    end

    def complete_spec(spec0)
      case spec0
      when /\A\$/
        "Kernel#{spec0}"
      else
        spec0
      end
    end

    def seems_code(text)
      # FIXME
      escape_html(text)
    end

    def string(str)
      @out.print str
    end

    def line(str)
      @out.puts str
    end

    def nl
      @out.puts
    end

  end

end