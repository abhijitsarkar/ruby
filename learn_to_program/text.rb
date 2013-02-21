class Text
  def greet
    puts "Hello there"

    puts "Please type in your first name and press ENTER"
    first_name = gets.chomp

    puts "Please type in your middle name and press ENTER"
    middle_name = gets.chomp

    puts "Please type in your last name and press ENTER"
    last_name = gets.chomp

    puts "Pleased to meet you " + first_name + " " +
    (middle_name.to_s == "" ? "" : (middle_name + " ")) + last_name
  end

  def favorite_number
    puts "Please type in your favorite number and press ENTER"
    fav_num = gets.chomp.to_i

  puts "Allow me to suggest a new favorite number, namely #{fav_num + 1}"
  end

  def start
    greet
    favorite_number
  end

  Text.new.start
end