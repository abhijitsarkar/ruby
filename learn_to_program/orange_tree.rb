#require 'thread'
require 'monitor'

class OrangeTree
  GROWTH_PER_YEAR = 1
  AGE_TO_START_PRODUCING_ORANGE = 3
  AGE_TO_DIE = 7
  ORANGE_COUNT_RELATIVE_TO_AGE = 50

  attr_reader :height, :age # create accessor method
  def initialize
    @height = 0
    @age = 0
    @orange_count = 0
  end

  def count_the_oranges
    return @orange_count
  end

  def one_year_passes
    if (@age == AGE_TO_DIE)
      puts "Sorry, the Orange tree is dead, can't increase the age anymore"
    else
      @age += 1
      @height += GROWTH_PER_YEAR
      @orange_count = Math.rand(@age..AGE_TO_DIE) * Math.log(@age) * ORANGE_COUNT_RELATIVE_TO_AGE
      puts "Increased age, height and made some Oranges available for picking"
    end
  end

  def pick_an_orange
    if (@age == AGE_TO_DIE)
      puts "Sorry, the Orange tree is dead, can't pick Oranges anymore"
    elsif (@orange_count > 0)
      @orange_count -= 1
      puts "The Orange is delicious"
    else
      puts "Sorry, no Oranges to pick"
    end
  end

end

class Worker
  def initialize
    @mon = Mutex.new
    #    @mon.extend(MonitorMixin)
    #    @cv1 = @mon.new_cond
    #    @cv2 = @mon.new_cond
    @cv1 = ConditionVariable.new
    @cv2 = ConditionVariable.new
    @next_run = :age
    @orange_tree = OrangeTree.new
  end

  def do_some_work
    orange_picker = Thread.start do
      #      until (@orange_tree.age == OrangeTree::AGE_TO_DIE)
      puts "Entering Orange picker sync block..."
      @mon.synchronize do
        puts "Entered Orange picker sync block"
        #          @cv.wait
        until (@next_run == :orange)
          @cv1.wait(@mon)
        end

        @orange_tree.pick_an_orange

        puts "Exiting Orange picker sync block..."
        #          sleep_time = rand(0..5)
        #          puts "Orange picker going to sleep for #{sleep_time}"
        #          sleep(sleep_time)
        #          puts "Orange picker woke up after sleeping for #{sleep_time}"
        @next_run = :age
        @cv2.signal
        puts "Orange picker signaled"
        #          puts "Orange picker waiting patiently..."
        #          @cv.wait(@mutex)
        #          puts "Orange picker waiting over"
      end
    end
    #    end

    age_increaser = Thread.start do
      #      until (@orange_tree.age == OrangeTree::AGE_TO_DIE)
      puts "Entering age increaser sync block..."
      @mon.synchronize do
        puts "Entered age increaser sync block"
        until (@next_run == :age)
          @cv2.wait(@mon)
        end
        @orange_tree.one_year_passes
        #          @cv.signal

        puts "Exiting age increaser sync block..."
        #          sleep_time = rand(0..5)
        #          puts "Age increaser going to sleep for #{sleep_time}"
        #          sleep(sleep_time)
        #          puts "Age increaser woke up after sleeping for #{sleep_time}"
        @next_run = :orange
        @cv1.signal
        puts "Age increaser signaled"
      end
    end
    #    end

    orange_picker.join
    age_increaser.join

  end

  worker = Worker.new

  100.times do |i|
    worker.do_some_work
  end

end