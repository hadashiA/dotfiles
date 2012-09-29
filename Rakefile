# coding: utf-8

desc "install the dot files into user's home directory"
task :default => :install
task :install => 'install:all'

def dot(file)
  File.expand_path("~/.#{file}")
end

namespace :install do
  task :all => [
    dot('emacs.d'),
    dot('vimrc'),
    dot('zshrc'),
    # dot('config'),  # fish shell configuration
    dot('screenrc'),
    dot('tmux.conf'),
    dot('vimperatorrc'),
    dot('globalrc'),
    dot('irbrc'),
    dot('railsrc'),
    dot('caprc'),
    # dot('autotest'),
    # dot('Xmodemap'),
  ]

  file dot('emacs.d')  => ['gems:rcodetools', 'gems:devel-which',
                           :rsense, :cmigemo,
                           :ruby_refm
                          ]
  file dot('vimrc')    => [dot('vim'), dot('gvimrc')]
  file dot('irbrc')    => ['gems:irbtools']
  file dot('zshrc')    => [dot('zsh'), dot('aliases'), dot('exports'), dot('gitrc')]
  file dot('screenrc') => [dot('screen')]
  file dot('autotest') => [dot('autotest_icons'),
                           'gems:rspec', 'gems:ZenTest',
                           'gems:RedGreen', 'gems:autotest-growl'
                          ]
  file dot('vimperatorrc') => [dot('vimperator')]

  file dot('rbenv') do 
    sh "git clone git://github.com/sstephenson/rbenv.git #{dot('rbenv')}"
    cd dot('rbenv') do 
      sh "mkdir plugins"
      cd "plugins" do 
        sh "git clone git://github.com/sstephenson/ruby-build.git"
      end
    end
  end

  file dot('nvm') do 
    sh "git clone git://github.com/creationix/nvm.git #{dot('nvm')}"
    cd dot('nvm') do
      sh %Q{sh "ruby -i -pe $_.gsub!(/(?<!builtin\s)(cd\s+)/, "builtin \\1")' nvm.sh"}
    end
  end

  rule /\/\..+?$/ => [proc {|task_name|
                        File.basename(task_name).sub(/^\./, '')
                      }] do |t|
    if !File.exist?(t.name) and !File.symlink?(t.name)
      ln_s t.source, t.name
    end
  end

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
  task :ruby_refm => ['doc/ruby-refm', 'doc/ruby-refm/bitclust/refe.index']

  file 'doc/ruby-refm' do |t|
    refm_version = 'ruby-refm-1.9.2-dynamic-20110729'
    refm_dir     = refm_version[/(\d{6})\d+$/, 1]
    url = "http://doc.ruby-lang.org/archives/#{refm_dir}/#{refm_version}.tar.gz"
    cd 'doc' do 
      sh "curl '#{url}' > ruby-refm.tar.gz"
      sh "tar xzf ruby-refm.tar.gz"
      ln_s refm_version, 'ruby-refm'
      sh "rm ruby-refm.tar.gz"
    end
  end

  file 'doc/ruby-refm/bitclust/refe.index' do 
    cd 'doc/ruby-refm/bitclust' do 
      sh "(ruby -Ilib bin/bitclust.rb --database ../db-1_9_2 list --class; ruby -Ilib bin/bitclust.rb --database ../db-1_9_2 list --method; ruby -Ilib bin/bitclust.rb --database ../db-1_9_2 list --library) > refe.index"
    end
  end

  desc 'install rsense. see http://cx4a.org/software/rsense/index.ja.html'
  task :rsense => dot('rsense')

  file dot('rsense') do
    rsense_dir = File.expand_path('~/dotfiles/opt/rsense')

    sh "ruby #{File.join(rsense_dir, 'etc/config.rb')} > $HOME/.rsense"
    sh "cat $HOME/.rsense"
  end

  desc "install C/Migemo (Kaoriya.net http://www.kaoriya.net/#CMIGEMO)"
  task :cmigemo => '/usr/local/bin/cmigemo'

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

  # Task alias

  desc "setup Emacs configuration. write .emacs and .emacs.d"
  task :emacs => dot('emacs.d')

  desc "setup Vim configuration. write .vimrc, .gvimrc .vim direcotry"
  task :vimrc => dot('vimrc')

  desc "setup .irbrc. install irbtools"
  task :irbrc => dot('irbrc')

  desc "setup .vimperator configuration. .vimepratorrc and .vimperator directory"
  task :vimperatorrc => dot('vimperatorrc')

  desc "setup Zsh configuration. write .zsh and .zshrc"
  task :zshrc => dot('zshrc')

  desc "setup fishshell configuration. .config direcotry"
  task :fish => dot('config')

  desc "setup Screen .screenrc and .screen"
  task :screenrc => dot('screenrc')

  desc "setup ruby autotest. notify icons. install rspec,ZenTest and other gems"
  task :autotest => dot('autotest')

  desc "install rbenv"
  task :rbenv => dot('rbenv')

  desc "install nvm"
  raks :nvm => dot('nvm')
end
