class DeafGrandma
  def random_year
    return rand(21) + 1930 # generate a random number between 1930 and 1950
  end

  def talk_to_grandma
    bye_count = 0

    while true do
      puts "Grandma says: Say (type in) something to grandma son. Don't forget to press ENTER when you're done"
      something = gets.chomp

      if (something == "BYE")
        bye_count +=1

        if (bye_count == 3)
          puts "Grandma says: BUY SONNY!"
          break;
        end
        next
      else
        bye_count = 0
      end

      if (something == something.upcase)
        puts "Grandma says: NO, NOT SINCE #{random_year}!"
      else
        puts "Grandma says: HUH?! SPEAK UP, SONNY!"
      end
    end

  end

  def start
    talk_to_grandma
  end

  DeafGrandma.new.start()

end