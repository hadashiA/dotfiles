require 'rbconfig'
require 'ftools'
require 'find'
require 'getoptlong'

DEFAULT_DEST_DIR = Config::CONFIG["sitelibdir"]
IGNORES = %w( RCS CVS .* *~ *.bak *.BAK core *.core #* .#* *.orig *.rej *.old )

unless File.respond_to?(:fnmatch)
  def File.fnmatch(pat, str)
    case pat[0]
    when nil
      not str[0]
    when ?*
      fnmatch(pat[1..-1], str) || str[0] && fnmatch(pat, str[1..-1])
    when ??
      str[0] && fnmatch(pat[1..-1], str[1..-1])
    else
      pat[0] == str[0] && fnmatch(pat[1..-1], str[1..-1])
    end
  end
end

def install(from, to)
  Find.find(from){|path|
    next if path == "."
    next if path == ".."

    base = File::basename(path)
    IGNORES.each{|pat|
      if File.fnmatch(pat, base)
        $stderr.puts "#{path}: pruned." if $DEBUG
        Find.prune
      end
    }

    st = File::lstat(path)
    dest = path.sub(from, to)
    mode = 0644

    if st.symlink?
      linksrc = File::readlink(path)
      File::symlink(linksrc, dest)
    elsif st.directory?
      File::makedirs(dest, true)
    else
      File::install(path, dest, mode, true)
    end
  }
end

destdir = DEFAULT_DEST_DIR
opt = GetoptLong.new
opt.set_options(
  [ "-d", "--destdir", GetoptLong::REQUIRED_ARGUMENT ]
)
begin
  opt.each_option{|name, val|
    case name
    when "-d"
      destdir = val
    end
  }
rescue
  exit 2
end

install("lib", destdir)
