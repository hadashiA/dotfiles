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
# Index Migemo's dictionary.
#
offset = 0
while line = gets
  unless line =~ /^;/
    print [offset].pack("N")
  end
  offset += line.length
end
