require 'thread'

Thread.abort_on_exception = true

class OrangeTree
  GROWTH_PER_YEAR = 1
  AGE_TO_START_PRODUCING_ORANGE = 3
  AGE_TO_DIE = 7
  ORANGE_COUNT_RELATIVE_TO_AGE = 50

  attr_reader :height, :age, :orange_count # create accessor method
  def initialize
    @height = 0
    @age = 0
    @orange_count = 0
  end

  def one_year_passes
    if (@age == AGE_TO_DIE)
      puts "Sorry, the Orange tree is dead, can't increase the age anymore"
    elsif (@age >= AGE_TO_START_PRODUCING_ORANGE)
      @age += 1
      @height += GROWTH_PER_YEAR
      @orange_count = (rand(@age..AGE_TO_DIE) * Math.log(@age) * ORANGE_COUNT_RELATIVE_TO_AGE).to_i
      puts "The age is #{@age}; there are #{@orange_count} Oranges on the tree"
    else
      @age += 1
      @height += GROWTH_PER_YEAR
      print "The age is #{@age}; sorry, the Orange tree is too young to be producing Oranges\n"
    end
  end

  def pick_an_orange
    if (@age == AGE_TO_DIE)
      print "Sorry, the Orange tree is dead, can't pick any more Oranges\n"
    elsif (@orange_count > 0)
      puts "The age is #{@age}; there are #{@orange_count} Oranges on the tree"
      @orange_count -= 1
      print "The Orange is delicious\n"
    else
      print "Sorry, no Oranges to pick\n"
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
        sleep_time = rand(0..5)
        print "Orange picker going to sleep for #{sleep_time}\n"
        sleep(sleep_time)
        print "Orange picker woke up after sleeping for #{sleep_time}\n"
        @mutex.synchronize do
          @orange_tree.pick_an_orange
          print "Orange picker waiting patiently...\n"
          if @orange_tree.age < OrangeTree::AGE_TO_DIE
            @cv.wait(@mutex)
          end
        end
      end
      print "Orange picker thread ending\n"
    end

    age_increaser = Thread.new do
      until (@orange_tree.age == OrangeTree::AGE_TO_DIE)
        sleep_time = rand(0..5)
        print "Age increaser going to sleep for #{sleep_time}\n"
        sleep(sleep_time)
        print "Age increaser woke up after sleeping for #{sleep_time}\n"
        @mutex.synchronize do
          @orange_tree.one_year_passes
          print "Age increaser increased the age\n"
          @cv.signal
        end
      end
      print "Age increaser thread ending\n"
    end

    # return threads so we can ensure they are joined in main
    [orange_picker, age_increaser]
  end

end

worker = Worker.new(Mutex.new, ConditionVariable.new, OrangeTree.new)
threads = worker.do_some_work

# ensure that each thread completes
threads.each {|t| t.join}