class Difference
  require 'thread'
  mutex = Mutex.new

  count1 = count2 = 0
  difference = 0
  Thread.new do
    loop do
      puts "Entering counter sync block..."
      mutex.synchronize do
        puts "Entered counter sync block"
        count1 += 1
        puts "Incremented count 1"
        count2 += 1
        puts "Incremented count 2"
      end
      puts "Exiting counter sync block..."
    end
  end
  Thread.new do
    loop do
      puts "Entering spy sync block..."
      mutex.synchronize do
        puts "Entered spy sync block"
        difference += (count1 - count2).abs
        puts "Did the difference"
      end
      puts "Exiting spy sync block..."
    end
  end
  sleep 1
  puts "Locking mutex..."
  mutex.lock
  #  counter.join
  #  spy.join
  puts "count1 :  #{count1}"
  puts "count2 :  #{count2}"
  puts "difference : #{difference}"
end