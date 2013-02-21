require 'monitor'

class MonitorExample

  Thread.abort_on_exception = true
  def try
    a = ""
    a.extend(MonitorMixin)
    next_run = :b

    cond_a = a.new_cond
    cond_b = a.new_cond

    t1 = Thread.start do
      a.synchronize do
        until next_run == :a
          cond_a.wait
        end

        a << "b"

        next_run = :b
        cond_b.signal
      end
    end

    t2,t3 = [2,3].map do
      Thread.start do
        a.synchronize do
          until next_run == :b
            cond_b.wait
          end

          a << "a"

          next_run = :a
          cond_a.signal
        end
      end
    end

    [t1,t2,t3].each{|t| t.join}

    return a
  end

  mon = MonitorExample.new

  1000.times do |i|
    puts "Looping..."
    output = mon.try
    raise "Oops! (#{i} says #{output})" unless output == "aba"
  end
end