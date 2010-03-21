require 'rake'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  
  Dir["*"].each do |file|
    next if skip?(file)

    original = File.join(ENV['HOME'], (dotfile?(file) ? ".#{file}" : file))

    if File.exist?(original) or File.symlink?(original)
      if replace_all
        replace_file(original)
        next
      end
      
      print "overwrite #{original}? [ynaq] "
      case $stdin.gets.chomp
      when 'a'
        replace_all = true
        replace_file(original)
      when 'y'
        replace_file(original)
      when 'q'
        exit
      else
        puts "skipping #{original}"
      end
    else
      link_file(original)
    end
  end
end

def skip?(file)
  %w(Rakefile README).include?(file) or file.match(/^(KeyRemap4|drnic-dot-files)/)
end

def dotfile?(file)
  !%w(bin opt).include?(file)
end

def replace_file(path)
  cmd = "rm -fr #{path}"
  puts cmd
  system cmd
  link_file path
end

def link_file(path)
  cmd = "ln -s #{File.join(ENV['PWD'], File.basename(path).sub(/^\./, ''))} #{path}"
  puts cmd
  system cmd
end
