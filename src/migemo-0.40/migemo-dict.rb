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

require 'bsearch'

class String
  def prefix_match (string)
    self[0, string.length] <=> string
  end
end

class MigemoDictItem
  def initialize(key, values)
    @key = key
    @values = values
    raise if @key == nil
    raise if @values == nil
  end

  attr_reader :key
  attr_reader :values
end

class MigemoDict
  def initialize (filename)
    @dict  = File.new(filename)
  end

  private
  def decompose (line)
    array = line.chomp.split("\t").delete_if do |x| x == nil end
    key = array.shift
    values = array
    raise if key == nil
    raise if values == nil
    return key, values
  end

  public
  def lookup (pattern)
    pattern = pattern.downcase
    raise "nil pattern" if pattern == nil
  end
end

class MigemoStaticDict < MigemoDict
  def initialize (filename)
    super(filename)
    @index = File.new(filename + ".idx").read.unpack "N*"
  end

  private
  def get_line (index)
    @dict.seek(index)
    @dict.gets
  end

  public
  def lookup (pattern)
    range = @index.bsearch_range do |idx| 
      key, values = decompose(get_line(idx))
      key.prefix_match(pattern)
    end
    if range 
      range.each do |i| 
	key, values = decompose(get_line(@index[i]))
	yield(MigemoDictItem.new(key, values)) 
      end
    end
  end
end

class MigemoUserDict < MigemoDict
  def initialize (filename)
    super(filename)
    @lines = @dict.readlines.delete_if {|x| /^;/ =~ x}.sort
  end

  def lookup (pattern)
    range = @lines.bsearch_range do |line| 
      key, values = decompose(line)
      key.prefix_match(pattern)
    end
    if range 
      range.each do |i| 
	key, values = decompose(@lines[i])
	yield(MigemoDictItem.new(key, values)) 
      end
    end
  end
end

class MigemoRegexDict < MigemoUserDict
end

class MigemoDictCache
  def initialize (filename)
    @dict  = File.new(filename)
    @index = File.new(filename + ".idx").read.unpack "N*"
  end

  def decompose (idx)
    @dict.seek(idx)
    keylen = @dict.read(4).unpack("N").first
    key = @dict.read(keylen).unpack("a*").first
    datalen  = @dict.read(4).unpack("N").first
    data     = Marshal.load(@dict.read(datalen))
    return key, data
  end
  private :decompose

  def lookup (pattern)
    raise if pattern == nil
    pattern = pattern.downcase
    idx = @index.bsearch_first do |idx| 
      key, data = decompose(idx)
      key <=> pattern 
    end
    if idx
      key, data = decompose(@index[idx])
      return data
    else
      nil
    end
  end
end


