# $kNotwork: forobject.rb,v 1.2 2002/01/14 16:20:15 gotoken Exp $

require "rbconfig"

module Devel
  module Which
    module ForObject
      def which_library(lib)
	unless lib.is_a? String
	  raise TypeError,
	    "wrong argument type #{lib.type} (expected String)"
	end
	ext = ["rb", Config::CONFIG["DLEXT"], Config::CONFIG["DLEXT2"]]
	ext.map!{|i| i.length > 0 ? ".#{i}" : nil}
	ext.compact!
	ext.push("")
	
	at = with = nil
	at = $:.find{|path|
	  file = "#{File::expand_path(path)}/#{lib}"
	  
	  begin
	    with = ext.find{|i|
	      test(?f, file+i) && test(?r, file+i)
	    }
	  rescue
	    next
	  end
	}
	
	"#{at}/#{lib}#{with}" if at
      end
      module_function :which_library

      def whereis_library(lib, opt = {})
	unless lib.is_a? String
	  raise TypeError,
	    "wrong argument type #{lib.type} (expected String)"
	end
	unless opt.is_a? Hash
	  raise TypeError,
	    "wrong argument type #{lib.type} (expected Hash)"
	end
	optpath = opt[:path] || opt[:p] || []
	optext = opt[:ext] || opt[:e] || ""
	ext = ["rb", Config::CONFIG["DLEXT"], Config::CONFIG["DLEXT2"], optext]
	ext.map!{|i| i.length > 0 ? ".#{i}" : nil}
	ext.compact!
	ext.push("")

	at = []

	($: + optpath).each{|path|
	  with = nil
	  file = "#{File::expand_path(path)}/#{lib}"
	  
	  begin
	    ext.each{|with|
	      if (test(?f, file+with) && test(?r, file+with) rescue false)
		at << "#{path}/#{lib}#{with}"
	      end
	    }
	  rescue
	    next
	  end
	}

	at
      end
      module_function :whereis_library
    end
  end
end
