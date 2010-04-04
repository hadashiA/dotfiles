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

#
# Convert a SKK's dictionary into Migemo's.
#
$KCODE= "e"
require 'romkan'

HIRAGANA = "[¤¡-¤ó¡¼¡Á]"
KANJI = "[°¡-ô¤]"

puts ";;"
puts ";; This is Migemo's dictionary generated from SKK's."
puts ";;"
lines = readlines
while line = lines.shift
  if /^;/ =~ line
    puts line
  else
    lastline = line
    break
  end
end
lines.unshift(lastline)

dict = [];
while line = lines.shift
  if /^(#{HIRAGANA}+)[a-z]? (.*)/ =~ line || /^(\w+) (.*)/ =~ line 
    head = $1
    words = $2.split('/').map {|x| 
      # remove annotations and elisp codes
      x.sub(/;.*/, "").sub(/^\((\w+)\b.+\)$/, "")
    }.delete_if {|x| x == ""}
    dict.push(sprintf("%s\t%s\n", head, words.join("\t")))
  end
end

dict.sort.uniq.each do |x| print x end
