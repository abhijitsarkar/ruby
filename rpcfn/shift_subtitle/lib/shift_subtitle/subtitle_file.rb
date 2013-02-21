require_relative 'command_line_parser'

module ShiftSubtitle
  class SubtitleFile
    SUBTITLE_REGEX = /(\d\d):(\d\d):(\d\d),(\d\d\d) --> (\d\d):(\d\d):(\d\d),(\d\d\d)/
    def initialize(input_file, output_file)
      @input_file = File.new(input_file, "r")
      @output_file = File.new(output_file, "w+")
    end

    public

    def shift(operation, timeshift)
      t = timeshift.split(",")
      begin
        IO.foreach(@input_file) do |line|
          m = line.match(SUBTITLE_REGEX)
          if (m == nil || m.length < 3)
            @output_file.write(line)
          else
            # m[0] is the whole line
            @output_file.write("#{shift_internal(m[1], m[2], m[3], m[4], operation, *t)} --> #{shift_internal(m[5], m[6], m[7], m[8], operation, *t)}\n")
          end
        end # end of loop foreach
      ensure
        @input_file.close
        @output_file.close
      end
    end # end of method shift

    private

    def shift_internal(hours, minutes, seconds, milliseconds, operation, timeshift_seconds, timeshift_milliseconds)

      ts = timeshift_seconds.to_i
      tms = timeshift_milliseconds.to_i

      h = hours.to_i
      m = minutes.to_i
      s = (operation  == "add" ? seconds.to_i + ts : seconds.to_i - ts )
      ms = (operation  == "add" ? milliseconds.to_i + tms : milliseconds.to_i - tms )

      if (ms > 999)
        s += 1
        ms -= 1000
      elsif (ms < 0)
        s -= 1
        ms = 1000 - ms.abs
      end
      if (s > 59)
        m += 1
        s -= 60
      elsif (s < 0)
        m -= 1
        s = 60 - s.abs
      end
      if (m > 59)
        h += 1
        m -= 60
      elsif (m < 0)
        h -= 1
        m = 60 - m.abs
      end

      "%02d" % h + ":%02d" % m + ":%02d" % s + ",%03d" % ms
    end

    #    cmd_parser = CommandLineParser.new
    #    cmd_parser.parse(ARGV)
    #    ip_file = cmd_parser.input_file
    #    op_file = cmd_parser.output_file
    #    timeshift = cmd_parser.time
    #    operation = cmd_parser.operation
    #
    #    subtitle_file = SubtitleFile.new(ip_file, op_file)
    #    subtitle_file.shift(operation, timeshift)
  end
end