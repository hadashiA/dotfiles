desc "install the dot files into user's home directory"
task :install => 'install:all'

namespace :install do
  task :all => [
    '.irbrc',
    '.emacs',
    '.vimrc',
    '.gvimrc',
    '.config',  # fish shell configuration
    '.zshrc',
    '.vimperatorrc',
    '.autotest',
  ]
  
  rule(/^\./ => lambda{|dotfile| File.join(ENV['PWD'], dotfile.sub(/^\./, ''))}) do |t|
    symlink_with_confirm t.source, File.expand_path("~/#{t.name}")
  end
  
  rule /(bin|opt|src)/ do |t|
    symlink_with_confirm File.join(ENV['PWD'], t.name), File.join(ENV['HOME'], t.name)
  end
  
  file '.emacs'        => ['.emacs.d', 'gems:fastri', 'gems:rcodetools', :devel_which, :rsense]
  file '.vimrc'        => ['.vim']
  file '.irbrc'        => ['gems:hirb', 'gems:wirble']
  file '.zshrc'        => ['.aliases', '.exports','.gitrc']
  file '.vimperatorrc' => ['.vimperator']
  file '.autotest'     => ['.autotest_icons']

  namespace :gems do
    rule /gems:/ do |t|
      gem_name = t.name.sub(/^gems:/, '')
      unless `gem list #{gem_name}`.include? gem_name
        puts '-' * 20
        cmd = "sudo gem install #{gem_name}"
        puts cmd
        puts
        system cmd
      end
    end
  end

  desc 'install devel/which. find ruby library path tool'
  task :devel_which => :src do
    `cd ./src/which-0.2.0/ && sudo ruby ./install.rb`
  end

  desc 'install rsense. see http://cx4a.org/software/rsense/index.ja.html'
  task :rsense => [:opt, :src] do
    `ruby ./opt/rsense/etc/config.rb > $HOME/.rsense`
    puts `cat $HOME/.rsense`
  end
end

@replace_flg = false
# create symlink
def symlink_with_confirm(src, dest)
  if @replace_flg
    rm_rf dest
    ln_s src, dest
    return
  end
  
  if File.exist?(dest) or File.symlink?(dest)
    print "overwrite #{dest}? [ynaq] "
    case $stdin.gets.chomp
    when 'a'
      @replace_flg = true
      rm_rf dest
      ln_s  src, dest
    when 'y'
      rm_rf dest
      ln_s  src, dest
    when 'q'
      exit
    end
  else
    ln_s src, dest
  end
end
