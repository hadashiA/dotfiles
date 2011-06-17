if RUBY_VERSION < '1.9'
  $KCODE = 'u'
end

require 'irb/completion'
require 'kconv'
require 'pp'
require 'rubygems'
# IRB.conf[:SAVE_HISTORY] = 100000


# begin
#   require 'wirble'
#   Wirble.init(:history_size => 10000)
#   Wirble.colorize

#   # Wirble::Colorize.colors = {
#   #   # delimiter colors
#   #   :comma              => :white,
#   #   :refers             => :white,
#   # 
#   #   # container colors (hash and array)
#   #   :open_hash          => :white,
#   #   :close_hash         => :white,
#   #   :open_array         => :white,
#   #   :close_array        => :white,
#   # 
#   #   # object colors
#   #   :open_object        => :light_red,
#   #   :object_class       => :red,
#   #   :object_addr_prefix => :blue,
#   #   :object_line_prefix => :blue,
#   #   :close_object       => :light_red,
#   # 
#   #   # symbol colors
#   #   :symbol             => :blue,
#   #   :symbol_prefix      => :blue,
#   # 
#   #   # string colors
#   #   :open_string        => :light_green,
#   #   :string             => :light_green,
#   #   :close_string       => :light_green,
#   # 
#   #   # misc colors
#   #   :number             => :light_blue,
#   #   :keyword            => :orange,
#   #   :class              => :red,
#   #   :range              => :light_blue,
#   # }
# rescue LoadError
#   puts "please run: `sudo gem install wirble`"
# end

# begin
#   require 'hirb'
#   Hirb.enable
#   extend Hirb::Console
# rescue LoadError
# #  puts "please run: `sudo gem install cldwalker-hirb --source http://gems.github.com`"
#   puts "please run: `sudo gem install hirb"
# end


if Object.const_defined?('Rails')
  require 'logger'
  putslogger = Logger.new(STDOUT)

  if ENV.include?('RAILS_ENV')&& !const_defined?('RAILS_DEFAULT_LOGGER')
    Object.const_set('RAILS_DEFAULT_LOGGER', putslogger)
  else
    if Object.const_defined?('ActiveRecord')
      ActiveRecord::Base.logger = putslogger
    end
    if Object.const_defined?('Mongoid')
      Mongoid.logger = putslogger
    end
  end
end

if Object.const_defined?('Bundler')
  Bundler.require(:irb)
else
  begin
    require 'irbtools'
  rescue LoadError
    puts "please run: `gem install irbtools"
  end
end

module Handy
  # Call Kernel#p method with self.
  def _p
    p self
    self
  end

  # Call Kernel#pp method with self.
  def _pp
    pp self
    self
  end


  # Call Kernel#puts method with self.
  def pt
    puts self
    self
  end

  # Stans for 'puts methods'.
  #
  # Show instance methods with detail.
  def pm(pattern = nil)
    klass = self.is_a?(Class) ? self : self.class
    ancs = klass.ancestors
    mtds = self.methods
    mtds = mtds.grep(pattern) if pattern
    mtds.sort.each do |e|
      ent = ancs.find {|c| c.instance_methods(false).include?(e) }
      ent ||= "self"
      puts "#{e} in #{ent}"
    end
  end

  # Stans for 'puts ancestors'.
  #
  # Show ancestors for self class. Included modules show with prefix '-'.
  def pa
    klass = self.is_a?(Class) ? self : self.class
    inc_mods = klass.included_modules
    klass.ancestors.each do |c|
      puts inc_mods.include?(c) ? "-#{c}" : "#{c}"
    end
  end

  # Stans for 'puts hierarchy'.
  #
  # Show classes extended or included self class.
  def ph
    klass = self.is_a?(Class) ? self : self.class
    ObjectSpace.each_object(Class).select {|c| c < klass }.pt
  end

  # Stans for 'puts class variables'.
  #
  # Show class variables name with value.
  def pcv
    klass = self.is_a?(Class) ? self : self.class
    klass.class_variables.each do |vn|
      puts "#{vn} = #{klass.class_eval(vn).inspect}"
    end
  end

  # Stans for 'puts instance variables'.
  #
  # Show instance variables name with value.
  def piv
    self.instance_variables.each do |vn|
      puts "#{vn} = #{self.instance_eval(vn).inspect}"
    end
  end

  def grep(pattern, glob)
    Dir.glob(glob).each do |path|
      content = open(path){|io| io.read }
      paths = []
      if content.match(pattern)
        paths << path           # 
        yield path, content if block_given?
      end
      paths
    end
  end

  def glob_replace(glob)
    Dir.glob(glob).each do |path|
      content = open(path){|io| io.read }
      content = yield(content)
      open(path, 'w'){|io| io.puts(content) }
    end
  end
end

Object.send(:include, Handy)
