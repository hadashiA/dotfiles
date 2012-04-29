# coding: utf-8

desc "install the dot files into user's home directory"
task :default => :install
task :install => 'install:all'

def dot(file)
  File.expand_path("~/.#{file}")
end

namespace :install do
  rule /\/\..+?$/ => [
    proc {|task_name| File.basename(task_name).sub(/^\./, '') }
  ] do |t|
    ln_s t.source, t.name
  end

  task :all => [
    dot('globalrc'),
    dot('irbrc'),
    dot('emacs.d'),
    dot('vimrc'),
    dot('zshrc'),
    dot('screenrc'),
    dot('vimperatorrc'),
    # dot('autotest'),
    # dot('config'),  # fish shell configuration
  ]

  file dot('emacs.d')      => ['gems:rcodetools', 'devel/which', dot('rsense'), '/usr/local/bin/cmigemo', 'doc/ruby-refm']
  file dot('vimrc')        => [dot('vim'), dot('gvimrc')]
  file dot('irbrc')        => ['gems:irbtools']
  file dot('zshrc')        => [dot('zsh'), dot('aliases'), dot('exports'), dot('gitrc')]
  file dot('screenrc')     => [dot('screen')]
  file dot('vimperatorrc') => [dot('vimperator')]
  file dot('autotest')     => [dot('autotest_icons'), 'gems:rspec', 'gems:ZenTest', 'gems:RedGreen', 'gems:autotest-growl']

  namespace :gems do
    rule /gems:/ do |t|
      gem_name = t.name.sub(/^gems:/, '')
      unless `gem list #{gem_name}`.include? gem_name
        puts '-' * 20
        sh "gem install #{gem_name}"
      end
    end
  end

  desc 'install devel/which. find ruby library path tool'
  task 'devel/which' do
    cd "src/which-0.2.0" do 
      sh "sudo ruby ./install.rb"
    end
  end

  desc "install ruby-refm"
  file 'doc/ruby-refm' do |t|
    url = 'http://doc.ruby-lang.org/archives/201107/ruby-refm-1.9.2-dynamic-20110729.tar.gz'
    sh "curl '#{url}' > ./doc/ruby-refm.tar.gz"
  end

  desc 'install rsense. see http://cx4a.org/software/rsense/index.ja.html'
  file dot('rsense') do
    rsense_dir = File.expand_path('~/dotfiles/opt/rsense')

    sh "ruby #{File.join(rsense_dir, 'etc/config.rb')} > $HOME/.rsense"
    sh "cat $HOME/.rsense"
  end

  desc "install C/Migemo (Kaoriya.net http://www.kaoriya.net/#CMIGEMO)"
  file '/usr/local/bin/cmigemo' do
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
  task :emacs => dot('emacs.d')

  desc "setup Vim configuration. write .vimrc, .gvimrc .vim direcotry"
  task :vim => dot('vimrc')

  desc "setup .irbrc"
  task :irb => dot('irbrc')

  desc "setup .vimperator configuration. .vimepratorrc and .vimperator directory"
  task :vimperator => dot('vimperatorrc')

  desc "setup .zshrc"
  task :zsh => dot('zshrc')

  desc "setup fishshell configuration. .config direcotry"
  task :fish => dot('config')

  desc "setup screen"
  task :screen => dot('screenrc')

  desc "setup ruby-refm"
  task :ruby_refm => 'doc/ruby-refm'
end
