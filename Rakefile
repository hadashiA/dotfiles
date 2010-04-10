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
    '.autotest',
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

  file '.emacs'        => ['.emacs.d', 'gems:fastri', 'gems:rcodetools', 'devel/which', :rsense, :cmigemo]
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
        sh "sudo gem install #{gem_name}"
      end
    end
  end

  desc 'install devel/which. find ruby library path tool'
  task 'devel/which' do
    cd "src/which-0.2.0" do 
      sh "sudo ruby ./install.rb"
    end
  end

  desc 'install rsense. see http://cx4a.org/software/rsense/index.ja.html , http://redmine.ruby-lang.org/wiki/rurema/'
  task :rsense => [opt, src] do
    current  = File.expand_path('~/opt/rsense')
    original = Dir[File.expand_path('./opt/rsense*')].sort.last

    rm_rf current
    ln_s original, current
    sh "ruby #{File.join(original, 'etc/config.rb')} > $HOME/.rsense"
    sh "cat $HOME/.rsense"

    current  = File.expand_path('~/src/rurema')
    original = Dir[File.expand_path('./src/ruby-refm*')].sort.last

    rm_rf current
    ln_s original, current
  end

  desc "install C/Migemo (Kaoriya.net http://www.kaoriya.net/#CMIGEMO)"
  task :cmigemo do
    cd "src/cmigemo-1.3c" do
      sh "./configure"
      sh "make osx"
      sh "make osx-dict"
      cd "dict" do 
        sh "make utf-8"
      end
      sh "sudo make osx-install"
    end
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
