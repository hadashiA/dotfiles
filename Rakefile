# coding: utf-8

desc "install the dot files into user's home directory"
task :default => :install
task :install => 'install:all'

def dot(file)
  File.expand_path("~/.#{file}")
end

namespace :install do
  task all: [:emacs, :vim, :tmux, :vimperator, :rbenv]

  desc 'intall rbenv'
  task :rbenv do 
    sh "git clone git://github.com/sstephenson/rbenv.git #{dot('rbenv')}"
    cd dot('rbenv') do 
      sh "mkdir plugins"
      cd "plugins" do 
        sh "git clone git://github.com/sstephenson/ruby-build.git"
      end
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

  desc "setup Emacs configuration. write .emacs and .emacs.d"
  task emacs: [dot('emacs.d')]

  desc "setup Vim configuration. write .vimrc, .gvimrc .vim direcotry"
  task vim: [dot('vimrc'), dot('vim'), dot('gvimrc')]

  desc "setup .vimperator configuration. .vimepratorrc and .vimperator directory"
  task vimperator: [dot('vimperatorrc'), dot('vimperator')]

  desc "setup Zsh configuration. write .zsh and .zshrc"
  task zsh: [dot('zshrc'), dot('zshenv'), dot('aliases'), dot('exports'), dot('gitrc')]

  desc "setup tmux"
  task tmux: [dot('tmux.conf')]
end
