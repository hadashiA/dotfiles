#
# Ruby/Migemo - a library for Japanese incremental search.
#
# Copyright (C) 2001 Satoru Takabayashi <satoru@namazu.org>
#     All rights reserved.
#     This is free software with ABSOLUTELY NO WARRANTY.
#
# You can redistribute it and/or modify it under the terms of 
# the GNU General Public License version 2.
#
# NOTE: Ruby/Migemo can work only with EUC_JP encoding. ($KCODE="e")
#

module MigemoRegex
  class RegexAlternation < Array
    def sort
      self.clone.replace(super)
    end

    def uniq
      self.clone.replace(super)
    end

    def map
      self.clone.replace(super {|x| yield(x)})
    end

    def delete_if
      self.clone.replace(super {|x| yield(x)})
    end

    def select
      self.clone.replace(super {|x| yield(x)})
    end
  end

  class RegexConcatnation < Array
    def map
      self.clone.replace(super {|x| yield(x)})
    end
  end

  class RegexCharClass < Array
  end

  class RegexCompiler
    def initialize
      @regex = RegexAlternation.new
    end
    attr_reader :regex

    private
    # ["運", "運動", "運転", "日本", "日本語"] => ["安" "運" "日本"]
    # (運|運動|運転|日本|日本語) => (安|運|日本)
    def optimize1 (regex)
      prefixpat = nil
      regex.sort.select do |word|
	if prefixpat && prefixpat.match(word) then
	  false # excluded
	else
	  prefixpat = Regexp.new(word.quotemeta)
	  true # included
	end
      end
    end

    # (あああ|ああい|ああう)
    # => (あ(あ(あ|い|う)))
    def optimize2 (regex)
      tmpregex = regex.sort.clone # I wish Array#cdr were available...
      optimized = RegexAlternation.new
      until tmpregex.empty?
	head = tmpregex.shift
	initial = head.first
	friends = RegexAlternation.new
	while item = tmpregex.first
	  if initial == item.first
	    friends.push(item.rest)
	    tmpregex.shift
	  else
	    break
	  end
	end
	if friends.empty?
	  optimized.push head
	else
	  concat = RegexConcatnation.new
	  concat.push(initial)
	  friends.unshift(head.rest) 
	  concat.push(optimize2(friends))
	  optimized.push(concat)
	end
      end
      return optimized
    end

    # (あ|い|う|え|お)
    # => [あいうえお]
    def optimize3 (regex)
      charclass = RegexCharClass.new
      if regex.instance_of?(RegexAlternation)
	regex.delete_if do |x|
	  if x.instance_of?(String) && x =~ /^.$/ then
	    charclass.push(x)
	    true
	  end
	end
      end

      if charclass.length == 1
	regex.unshift charclass.first
      elsif charclass.length > 1
	regex.unshift charclass
      end

      regex.map do |x|
	if x.instance_of?(RegexAlternation) || x.instance_of?(RegexConcatnation)
	  optimize3(x)
	else
	  x
	end
      end
    end

    public
    def push (item)
      @regex.push(item)
    end

    def uniq
      @regex.uniq
    end

    def optimize (level)
      @regex = optimize1(@regex) if level >= 1
      @regex = optimize2(@regex) if level >= 2
      @regex = optimize3(@regex) if level >= 3
    end
  end

  class RegexMetachars
    def initialize
      @bar = '|'
      @lparen = '('
      @rparen = ')'
    end
    attr_accessor :bar
    attr_accessor :lparen
    attr_accessor :rparen
  end

  class RegexEgrepMetachars < RegexMetachars
  end

  class RegexPerlMetachars < RegexMetachars
    def initialize
      @bar = '|'
      @lparen = '(?:'
      @rparen = ')'
    end
  end

  class RegexRubyMetachars < RegexMetachars
  end

  class RegexEmacsMetachars < RegexMetachars
    def initialize
      @bar = '\\|'
      @lparen = '\\('
      @rparen = '\\)'
    end
  end

  class RegexRenderer
    def initialize (regex, insertion)
      raise if regex == nil
      @regex = regex
      @meta = RegexMetachars.new
      @insertion = insertion
      @with_paren = false
    end
    attr_accessor :with_paren

    private
    def render_alternation (regex)
      if regex.length == 0
	raise
      elsif regex.length == 1
	render0(regex[0])
      else
	@meta.lparen + 
	  regex.map {|x| render0(x) }.join(@meta.bar) + 
	  @meta.rparen
      end
    end

    def render_concatnation (regex)
      regex.map {|x| render0(x) }.join(@insertion)
    end

    def escape_string (string)
      string.quotemeta
    end

    def escape_charclass (string)
      string.gsub(/\\/, '\\\\\\')
    end

    def render_charclass (regex)
      if regex.delete("-")
	regex.push("-")  # move "-" to the end of Array.
      end
      if regex.delete("]")
	regex.unshift("]")  # move "]" to the beginning of Array.
      end
      escape_charclass("[" + regex.join + "]")
    end

    def insert (string)
      if @insertion != ""
	tmp = string.gsub(/(\\.|.)/, "\\1#{@insertion}")
	tmp = tmp.sub(/#{@insertion.quotemeta}$/, "")
      else
	string
      end
    end

    def render_string (regex)
      insert(escape_string(regex))
    end

    def render0 (x)
      if x.instance_of?(RegexAlternation)
	render_alternation(x)
      elsif x.instance_of?(RegexConcatnation)
	render_concatnation(x)
      elsif x.instance_of?(RegexCharClass)
	render_charclass(x)
      elsif x.instance_of?(String)
	render_string(x)
      else
	raise "unexpected type: #{x} of #{x.class}"
      end
    end

    public
    def render
      if @with_paren  # e.g. "(a|b|c)"
        render0(@regex)
      else            # e.g. "a|b|c"
        @regex.map do |x|
          render0(x)
        end.join @meta.bar
      end
    end

    def join_regexes (string, regexes)
      ([string] + regexes).join @meta.bar
    end
  end

  class RegexPerlRenderer < RegexRenderer
    def initialize (regex, insertion)
      super(regex, insertion)
      @meta = RegexPerlMetachars.new
    end
  end

  class RegexRubyRenderer < RegexPerlRenderer
  end

  class RegexEgrepRenderer < RegexRenderer
  end

  class RegexEmacsRenderer < RegexRenderer
    def initialize (regex, insertion)
      super(regex, insertion)
      @meta = RegexEmacsMetachars.new
    end

    def escape_string (string)
      str = string.quotemeta
      str.gsub!(/\\\(/, "(")
      str.gsub!(/\\\)/, ")")
      str.gsub!(/\\\|/, "|")
      str.gsub!(/\\\</, "<")
      str.gsub!(/\\\>/, ">")
      str.gsub!(/\\\=/, "=")
      str.gsub!(/\\\'/, "'")
      str.gsub!(/\\\`/, "`")
      str.gsub!(/\\\{/, "{")
      str
    end

    def escape_charclass (string)
      string
    end
  end

  module RegexMetacharsFactory
    def new (type)
      case type
      when nil
	RegexRubyMetachars.new
      when "emacs"
	RegexEmacsMetachars.new
      when "perl"
	RegexPerlMetachars.new
      when "ruby"
	RegexRubyMetachars.new
      when "egrep"
	RegexEgrepMetachars.new
      else
	raise "Unknown type: #{type}"
      end
    end
    module_function :new
  end

  module RegexRendererFactory
    def new (regex, type, insertion)
      case type
      when nil
	RegexRubyRenderer.new(regex, insertion)
      when "emacs"
	RegexEmacsRenderer.new(regex, insertion)
      when "perl"
	RegexPerlRenderer.new(regex, insertion)
      when "ruby"
	RegexRubyRenderer.new(regex, insertion)
      when "egrep"
	RegexEgrepRenderer.new(regex, insertion)
      else
	raise "Unknown type: #{regex}"
      end
    end
    module_function :new
  end

end

