# https://gist.github.com/cfeduke/5b371226faf83af50d7e
# average_time.rb
# makes assumptions about times fed between midday and midnight
# if the lowest time is closer to midnight than the latest time is to midday, assumes we are crossing
# midnight while averaging

require 'time'

SECONDS_IN_DAY = 86400
MIDNIGHT = Time.parse("12:00AM").to_i
MIDDAY = Time.parse("12:00PM").to_i

def average_time_of_day(times)
  seconds = []
  times.each {|time| seconds << Time.parse(time).to_i}
  seconds.sort!
  if (seconds.first - MIDNIGHT) < (seconds.last - MIDDAY)
    seconds.map! {|s| s < MIDDAY ? s += SECONDS_IN_DAY : s }
  end
  Time.at(seconds.inject { |sum,n| sum += n }.to_f / seconds.length).strftime("%I:%M%p").downcase
end