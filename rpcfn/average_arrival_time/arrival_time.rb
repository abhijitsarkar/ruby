require 'time'

class ArrivalTime < Time
  def self.average_arrival_time(*args)
    average = 0
    args.each_with_index do |time, index|
      if (index > 0)
        previous = Time.parse(args[index - 1])
        current = Time.parse(time)
        if (am?(time) && (not am?(previous.strftime('%I:%M%P'))))
          now = Time.now
          current = Time.local(now.year, now.month, (now.day + 1),
          current.hour, current.min, current.sec)
        end
        average += current - previous
      end
    end
    average = (average / 2).floor
    average_time_of_day = Time.parse(args[0]) + average
    "#{average_time_of_day.strftime('%I:%M%P')}"
  end

  private

  def self.am?(time)
    time.end_with?("am")
  end

end