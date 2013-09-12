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
          @parser.on("--#{sel} N", cls){|v| @struct[sel.to_sym] = v }
        end
        @parser.on()
      end
      def on(*args, &blk)
        @parser
      end
    end
  end
  #######################
  # usage:
  # opt = Accel::optparse!(ARGV){
  #   on("-r","--num_roots N"){|o| @num_roots = o }
  #   # or shorthand (uses flag name for opt member)
  #   num_roots 1
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
