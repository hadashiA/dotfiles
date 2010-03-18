require 'rake'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir["*"].each do |file|
    puts file
    next if %w[Rakefile README bin].include? file
    next if file.match(/^KeyRemap4/)

    original = File.join(ENV['HOME'], ".#{file}")

    if File.exist?(original) || File.symlink?(original)
      if replace_all
        replace_file(file)
      else
        print "overwrite #{original}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping #{original}"
        end
      end
    else
      link_file(file)
    end
  end
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
