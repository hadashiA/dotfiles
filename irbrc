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

begin
  require 'irbtools'
rescue LoadError
  puts "please run: `gem install irbtools"
end


class Object
  # Return a list of methods defined locally for a particular object.  Useful
  # for seeing what it does whilst losing all the guff that's implemented
  # by its parents (eg Object).
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end

if Object.const_defined?('Rails')
  require 'logger'
  if ENV.include?('RAILS_ENV')&& !const_defined?('RAILS_DEFAULT_LOGGER')
    Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
  else
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end
end






