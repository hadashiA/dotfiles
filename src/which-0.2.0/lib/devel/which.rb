#! /usr/local/bin/ruby
# $kNotwork: which.rb,v 1.3 2002/02/08 19:52:57 gotoken Exp $

require "devel/which/forobject"
require "devel/which/formodule"

module Devel
  module Which
    VERSION = "0.2.0"
  end
end

class Object
  def which_library(name)
    Devel::Which::ForObject::which_library(name)
  end

  def whereis_library(name)
    Devel::Which::ForObject::whereis_library(name)
  end
end

class Module
  def which_constant(name)
    Devel::Which::ForModule::which_constant(self, name)
  end

  def which_method(name)
    Devel::Which::ForModule::which_method(self, name)
  end
end

if __FILE__ == $0
  def show(str = nil, hidden = nil)
    if str
      print("#{str.ljust(25)}")
      val = eval(str)
      puts(hidden ? "" : " #=> #{val.inspect}" )
    else
      puts("")
    end
  end
  
  show %{Fixnum.which_method :nonzero?}  #=> Numeric
  show %{Fixnum.which_method :integer?}  #=> Integer
  show %{Fixnum.which_method :zero?}     #=> Fixnum
  show %{Array.which_method :sort}       #=> Array
  show %{Array.which_method :find}       #=> Enumerable
  show
  show %{File::Constants.which_constant("IO")} #=> Object
  show %{File::Constants.which_constant("Constants")} #=> File
  show %{File::Constants.which_constant("TRUNC")} #=> File::Constants
  show %{
    module M0
      X = 0
      Z = 0
    end

    module M1
      X = 1
      Y = "1"

      module C
	Y = "1"
      end
    end

    module M2
      include M0
      Z = 0
    end

    module A
      X = nil

      module B
	include M1

	module C
	  include M2
	end
      end
    end}, true
  show
  show %{A::B::C.which_constant("X")} #=> A
  show %{A::B::C.which_constant("Y")} #=> nil
  show %{A::B::C.which_constant("Z")} #=> M0
  show
  show %{which_library "xmp"}
  show %{which_library "irb"}
  show %{which_library "irb/xmp"}
  show %{which_library "nkf"}
  show %{which_library "which.rb"}
  show
  show %{whereis_library "uri"}
  show %{whereis_library "tk"}
end
