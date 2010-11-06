# coding: utf-8

puts ARGV.first.bytes.to_a.map{|i| i.to_s(2) }.join.each_char.map{|c| c.to_i.zero? ? 'Hey' : 'パス' }.join
