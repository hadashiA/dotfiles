module Devel
  module Which
    def name2string(name)
      name = name.id2name if name.is_a? Symbol
      unless name.is_a? String
	raise TypeError,
	  "wrong argument type #{name.type} (expected String or Symbol)"
      else
	name
      end
    end
    module_function :name2string
  end
end
