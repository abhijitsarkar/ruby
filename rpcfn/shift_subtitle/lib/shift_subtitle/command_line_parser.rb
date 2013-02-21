require 'optparse'

#require 'pp'
module ShiftSubtitle
  class CommandLineParser
    def initialize
      @options = {}
      @args = []
    end

    def operation
      @options[:o].to_s
    end

    def time
      @options[:t].to_s
    end

    def input_file
      @args[0]
    end

    def output_file
      @args[1]
    end

    def parse(args, reraise = false)
      options = {}
      op = OptionParser.new do |opts|
        opts.banner = "usage: command_line_parser.rb [options] input_file output_file"

        # mandatory argument operation

        # the optparse seems to be doing a "starts with" matching on the set of
        # restricted arguments. 'a' is treated as 'add' and 's' is treated as
        # 'subtract'. not exactly what I wanted but I'll live with it
        opts.on("-o", "--operation add|subtract", [:add, :subtract]) do |o|
          options.merge!(:o => o)
        end

        # mandatory argument time
        opts.on("-t", "--time time",
        "Where time is in the format ss,mmm where \"ss\" is the",
        "  amount of seconds and \"mmm\" the amount of milliseconds.") do |t|
          if (not t =~ /\d\d,\d\d\d/)
            raise OptionParser::InvalidArgument, "#{t}"
          end
          options.merge!(:t => t)
        end

        # optional argument help
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          #          exit 0
        end
      end

      begin
        op.parse!(args)
        @options = options
        @args = args
        if (@options.length != 2)
          raise OptionParser::AmbiguousOption, "Wrong number of options"
        elsif (@args.length != 2)
          raise OptionParser::AmbiguousArgument, "Wrong number of arguments"
        end
      rescue OptionParser::ParseError => e
        puts e
        puts op
        #      pp "Options:", @options
        #      pp "ARGV:", @args
        raise e, "This should only be used for Unit Testing" if reraise
        #        exit 1
      end
    end # end method parse
  end # end class CommandLineParser
end # end of module ShiftSubtitle