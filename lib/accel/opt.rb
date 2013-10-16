if not OpenStruct.method_defined? :[]=
  class OpenStruct
    def []=(s, val)
      new_ostruct_member(s)
      send("#{s}=".to_sym, val)
    end
    def [](s)
      send(s)
    end
  end
end


module Accel
  module Impl
    class OptDSL
      def initialize(parser,struct)
        @parser = parser
        @struct = struct
      end
      def method_missing(sel, *args, &blk)
        if args.length == 1 # shorthand syntax: 'flag default'
          default = args[0]
          cls = default.class
          cls = Integer if cls == Fixnum
          
          @struct[sel.to_sym] = default
          
          if cls == true.class || cls == false.class # is Boolean
            @parser.on("--[no-]#{sel}"){|b| @struct[sel.to_sym] = b }
          else
            @parser.on("--#{sel} N", cls){|v| @struct[sel.to_sym] = v }
          end
        end
      end
      # def on(*args, &blk)
      #   @parser(*args, &blk)
      # end
    end
  end
  #######################
  # usage:
  # opt = Accel::optparse!(ARGV){
  #   on("-r","--num_roots N"){|o| @num_roots = o }
  #   # or shorthand (uses flag name for opt member)
  #   num_roots 1
  #   # or boolean flags, e.g.: --[no-]verbose
  #   verbose false
  # }
  def self.optparse!(argv = ARGV, &blk)
    require 'optparse'
    require 'ostruct'
    
    s = OpenStruct.new
    OptionParser.new {|o|
      Impl::OptDSL.new(o,s).instance_eval(&blk)
    }.parse!(argv)
    return s
  end
end
