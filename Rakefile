desc "install the dot files into user's home directory"
task :install => 'install:all'

namespace :install do
  task :all => [
    # 'bin',
    '.irbrc',
    '.emacs',
    '.vimrc',
    '.gvimrc',
    '.config',  # fish shell configuration
    '.zshrc',
    '.vimperatorrc',
    # '.autotest',
  ]
  
  bin = File.expand_path("~/bin")
  opt = File.expand_path("~/opt")
  src = File.expand_path("~/src")

  directory bin
  directory opt
  directory src

  desc "install local scripts"
  task 'bin' => bin do
    p FileList['bin/*']
  end
  
  rule(/^\./ => lambda{|dotfile| File.expand_path("./#{dotfile.sub(/^\./, '')}") }) do |t|
    ln_s_confirm t.source, File.expand_path("~/#{t.name}")
  end

  file '.emacs'        => ['.emacs.d', 'gems:fastri', 'gems:rcodetools', 'devel/which', :rsense]
  file '.vimrc'        => ['.vim']
  file '.irbrc'        => ['gems:hirb', 'gems:wirble']
  file '.zshrc'        => ['.aliases', '.exports','.gitrc']
  file '.vimperatorrc' => ['.vimperator']
  file '.autotest'     => ['.autotest_icons', 'gems:rspec', 'gems:ZenTest', 'gems:RedGreen', 'gems:autotest-growl']

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
  task 'devel/which' do
    `cd ./src/which-0.2.0/ && sudo ruby ./install.rb`
  end

  desc 'install rsense. see http://cx4a.org/software/rsense/index.ja.html'
  task :rsense => [opt, src] do
    ln_s_confirm File.expand_path('./opt/rsense'), File.join(opt, 'rsense')
    ln_s_confirm File.expand_path('./src/rurema'), File.join(src, 'rurema')
    `ruby ./opt/rsense/etc/config.rb > $HOME/.rsense`
    puts `cat $HOME/.rsense`
  end
end

@replace_flg = false
# create symlink
def ln_s_confirm(src, dest)
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
