require 'migemo'
$KCODE="e"
raise if ARGV[0] == nil
dict = ARGV[0]
static_dict = MigemoStaticDict.new(dict)
ARGV.shift

cache  = File.new(dict + ".cache", "w")
index  = File.new(dict + ".cache.idx", "w")

idx = 0
lines = readlines.sort
lines.each do |line|
  pattern = line.chomp!
  $stderr.puts pattern
  next if pattern == ""

  migemo = Migemo.new(static_dict, pattern)
  migemo.optimization = 3
  data = Marshal.dump(migemo.regex_tree)
  output = [pattern.length].pack("N") + pattern + 
    [data.length].pack("N") + data
  cache.print output
  index.print [idx].pack("N")
  idx += output.length
end

