class Arrays
  POSITIVE_INFINITY = +1.0/0.0

  private
  def merge(left, right)

    merged = []
    left  << POSITIVE_INFINITY
    right << POSITIVE_INFINITY

    i = 0
    j = 0
    k = 0

    while (k < (left.length + right.length - 2)) do
      if (left[i] <= right[j])
        merged[k] = left[i]
        i += 1
      else
        merged[k] = right[j]
        j += 1
      end # end of if block
      k += 1
    end # end of while loop

    merged
  end # end of method merge

  public

  def merge_sort(words)

    len = words.length

    if (len <= 1)
      return words
    end

    q = (len / 2).floor
    left = words[0, q]
    right = words[q, len]
    left = merge_sort(left)
    right = merge_sort(right)

    merge(left, right)
  end # end of method merge_sort

  #  def accept
  #    @words = []
  #
  #    puts "Keep typing, one word per line. To finish, press ENTER on a blank line"
  #    while true do
  #      word = gets.chomp
  #
  #      if (word.to_s == "")
  #        puts "The words you entered will now be repeated back in alphabetical order"
  #        #puts @words.sort
  #        puts merge_sort1(@words)
  #
  #        break
  #      else
  #        @words.push word
  #      end # end of if block
  #    end # end of while loop
  #  end # end of method accept
  #
  #  Arrays.new.accept

end