desc "install the dot files into user's home directory"
task :install => 'install:all'

namespace :install do
  task :all => [
    '.tags',
    '.globalrc',
    '.irbrc',
    '.emacs',
    '.vimrc',
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
  
  rule(/^\./ => lambda{|dotfile| File.expand_path("./#{dotfile.sub(/^\./, '')}") }) do |t|
    ln_s_confirm t.source, File.expand_path("~/#{t.name}")
  end

  # file '.emacs'        => ['.emacs.d', 'gems:rcodetools', 'devel/which', :rurema, :rsense, :cmigemo]
  file '.emacs'        => ['.emacs.d', 'gems:rcodetools', 'devel/which', :rsense, :cmigemo]
  file '.vimrc'        => ['.vim', '.gvimrc']
  file '.irbrc'        => ['gems:hirb', 'gems:wirble']
  file '.zshrc'        => ['.zsh', '.aliases', '.exports','.gitrc']
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

  desc "install ruby refm (るりま) see http://redmine.ruby-lang.org/wiki/rurema/"
  task :rurema => src do |t|
    # source = Dir[File.expand_path('./src/ruby-refm*')].sort.last
    # source = File.expand_path('./src/ruby-refm-1.9.0-dynamic')
    dest   = File.join(src, 'rurema')
    source = File.expand_path('./src/rurema')

    rm_f dest
    ln_s source, dest

    cd dest do
      cmd =  "ruby1.9 #{File.expand_path('./bin/ar-index.rb')} ./rubydoc ./rurema.e"
      puts cmd
    end
  end

  desc 'install rsense. see http://cx4a.org/software/rsense/index.ja.html'
  # task :rsense => [opt, :rurema] do
  task :rsense => [opt] do
    current  = File.expand_path('~/opt/rsense')
    original = Dir[File.expand_path('./opt/rsense*')].sort.last

    rm_rf current
    ln_s original, current
    sh "ruby #{File.join(original, 'etc/config.rb')} > $HOME/.rsense"
    sh "cat $HOME/.rsense"
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

  desc "setup Emacs configuration. write .emacs and .emacs.d"
  task :dotemacs => '.emacs'

  desc "setup Vim configuration. write .vimrc, .gvimrc .vim direcotry"
  task :dotvimrc => '.vimrc'

  desc "setup .irbrc"
  task :dotirbrc => '.irbrc'

  desc "setup .vimperator configuration. .vimepratorrc and .vimperator directory"
  task :dotvimperatorrc => '.vimperatorrc'

  desc "setup .zshrc"
  task :dotzshrc => '.zshrc'

  desc "setup fishshell configuration. .config direcotry"
  task :dotconfig => '.config'
end

# create symlink
def ln_s_confirm(src, dest)
  if File.exist?(dest) or File.symlink?(dest)
    print "overwrite #{dest}? [yn] "
    if $stdin.gets.chomp == 'y'
      rm_rf dest
      ln_s  src, dest
    end
  else
    ln_s src, dest
  end
end
