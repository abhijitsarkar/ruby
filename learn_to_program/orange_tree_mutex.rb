# runs into a deadlock, does not work in it's current version
require 'thread'

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
    @age += 1
    @height += GROWTH_PER_YEAR
    @orange_count = Math.rand(@age..AGE_TO_DIE) * Math.log(@age) * ORANGE_COUNT_RELATIVE_TO_AGE
  end

  def pick_an_orange
    if (@age == AGE_TO_DIE)
      puts "Sorry, the Orange tree is dead"
    elsif (@orange_count > 0)
      @orange_count -= 1
      puts "The Orange is delicious"
    else
      puts "Sorry, no Oranges to pick"
    end
  end

end

class Worker
  attr_reader :orange_tree # create accessor method
  def initialize(mutex, cv, orange_tree)
    @mutex = mutex
    @cv = cv
    @orange_tree = orange_tree
  end

  def do_some_work
    orange_picker = Thread.new do
      until (@orange_tree.age == OrangeTree::AGE_TO_DIE)
        @mutex.synchronize do
          sleep_time = rand(0..5)
          puts "Orange picker going to sleep for #{sleep_time}"
          sleep(sleep_time)
          puts "Orange picker woke up after sleeping for #{sleep_time}"
          @orange_tree.pick_an_orange
          puts "Orange picker waiting patiently..."
          @cv.wait(@mutex)
        end
      end
    end

    age_increaser = Thread.new do
      until (@orange_tree.age == OrangeTree::AGE_TO_DIE)
        @mutex.synchronize do
          sleep_time = rand(0..5)
          puts "Age increaser going to sleep for #{sleep_time}"
          sleep(sleep_time)
          puts "Age increaser woke up after sleeping for #{sleep_time}"
          @orange_tree.one_year_passes
          puts "Age increaser increased the age"
          @cv.signal
        end
      end
    end

    orange_picker.join
    age_increaser.join

  end

  worker = Worker.new(Mutex.new,ConditionVariable.new,OrangeTree.new)
  worker.do_some_work

end