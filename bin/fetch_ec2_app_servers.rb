#!/usr/bin/ruby

servers_result = `cap production_mixi amazon::app_servers`
# servers_result = 'Production apps servers list: ["204.236.205.249", "204.236.243.113"]'
# puts servers_result

ips = servers_result.scan(/(([0-9]+\.){3}[0-9]+)/).map{|m0, m1| m0  }
ips.each_with_index do |ip, i|
  i += 1
  puts "* prod_app_#{i}. #{ip}"
end

ssh_config_path = File.expand_path('~/.ssh/config')

if FileTest.exists? ssh_config_path
  ssh_config = open(ssh_config_path){|f| f.read }
  ssh_config.gsub!(%r{^\s*(Host\s+prod_app_[0-9].+)(Host\s|$)}m, '')
else
  ssh_config = ''
end

i = 0
prod_app_configs = ips.collect do |ip|
  i += 1
<<-CONF

Host prod_app_#{i}
  User     ddunit_user
  HostName #{ip}
CONF
end.join('') + "\n"

ssh_config << prod_app_configs
puts ssh_config
print "write in it at '#{ssh_config_path}' ? (y/n): "

if $stdin.gets.chomp == 'y'
  open(ssh_config_path, 'w'){|f| f.puts(ssh_config) }
end
