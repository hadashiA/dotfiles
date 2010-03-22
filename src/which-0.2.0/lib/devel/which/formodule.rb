# $kNotwork: formodule.rb,v 1.2 2002/02/08 19:52:57 gotoken Exp $

require "devel/which/libwhich"

module Devel
  module Which
    module ForModule
      def which_constant(mod, name)
	name = Devel::Which::name2string(name)
	nest = []
	pos = 0
	  space = mod.name
	begin
	  pos -= 1
	  space = space[0..pos]
	  nest.push(space)
	end while pos = space.rindex(/::/)
	nest.map!{|i| eval "::#{i}"}
	mod.ancestors.each{|i| nest.push i}
	a = (class <<self; self; end).ancestors.each{|i| nest.push i}
	
	cand = nest.find_all{|m| m.const_defined? name}
	
	last = cand.shift
	return nil if not last
	value = last.const_get(name)
	
	while car = cand.shift
	  break if value != car.const_get(name)
	  last = car
	end
	
	last
      end
      module_function :which_constant

      def which_method(mod, name)
	name = Devel::Which::name2string(name)
	
	mod.ancestors.find{|a|
	  a.instance_methods.include?(name)
	}
      end
      module_function :which_method
    end
  end
end
