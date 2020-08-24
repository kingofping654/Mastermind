puts "\nWelcome to Mastermind! Find out if your smart enough to crack the computers mysterious code. You can even create your own code for the computer to solve. If you want to crack the computers code type game_1 = Mastermind.new(\"player name here\") and then type game_1.start_game. If you want to have the computer try to crack your code type game_1 = ComputerTriesToGuess.new(\"player name here\") and then type game_1.computers_turn. If you want the rules type puts rules in the command line.\n"

rules = puts "\nHow to crack the computers code: You have 6 colors to choose from (red, green, blue, yellow, orange, and brown). When prompted type in four of the 6 colors seperated by a space. When you are done press the enter key. Remember no repeating colors but case for the colors does not matter. Based on your answer you will be returned 4 words. If the word is blank that means the color you guessed for that spot is not in the code at all. If the whord is white that means you got the right color it is just in the wrong order. if the word is black you got the right color in the right spot. You have 12 turns to guess the code or you lose If you want to see if the computer can solve your code when prompted type in 4 of these colors (red, green, blue, yellow, orange, and brown) and press the enter key. Remember do not repeat coors and the case still doesn't matter. The computer will have 12 turns to guess.\n"


# The main class to play the game
class Mastermind
  # A random computer name from the list below is given to the computer each new game. possible codes also has the list of colors that can make up the code. 4 colors are chose to make up the code.
  @@computer_names = ["Hal", "Kit", "Bat-Computer", "Karen", "NICOLE", "Glados", "Bishop", "EDI", "Cortana", "Guilty Spark", "John Henry Eden", "ADA", "Dummy Plug", "Shodan", "Jarvis", "The Magi", "Sigma", "SARA", "Lappy-486", "Stem", "Ava", "Samantha"]
    @@computer = @@computer_names.sample
    @@possible_codes = ["red", "green", "blue", "yellow", "brown", "orange"]
    @@code = @@possible_codes.sample(4)
    @@result = Array.new
    @@answer = 

  # The method that initialzes the game and allows the player to enter their name. If a name is not chosen it falls back onto a default.
  def initialize(player1 = "Player 1")
    @player1 = player1
    @turn_count = 0
  end

  # The method that begins the game itself
  def start_game
    puts "\n#{@@computer} has created its code. Can you crack it?\n"
   
    
  # A loop that will run 12 times or until the player guesses the code. It begins by asking the player to input what they think the code is and then turning that into an array. 
   12.times do
      puts "#{@player1} what do you think the code is?\n"
      answer = gets.chomp.downcase.split()
      @turn_count += 1

    # A bit of logic in case the 
      unless answer.include?("red") || answer.include?("green") || answer.include?("blue") || answer.include?("yellow") || answer.include?("brown") || answer.include?("orange") && answer.length == 4
        puts "Only type in colors that you think might be in the code seperated by a space. Remember no color is repeated."
        answer = gets.chomp.downcase.split()
      end
  
     # This enumerable tests the guesses to see if they match the code. If the player gets the color and the location they get red. If they only get the color they get white. If the guess misses both they are given a blank. The i variable is to ensure that the enumerable only covers 4 guesses.  
      i = 0
result = answer.map do |color|

  if color == @@code[i] && i <= 3
    i += 1
    color = "black"
   
  elsif color != @@code[i] && @@code.include?(color) && i <= 3
    i+= 1
    color = "white"
  
  else
    i += 1
    color ="blank"
  end
end
      
      puts "\n#{result}\n" 

    # This will break the loop early if the player guesses the code prior to twelve turns being up.
      break if result == ["black", "black", "black", "black"]
      @@result = Array.new
      i = 0
      answer = nil
  end
 
    # Based on how the player did they are given a different message. They are also prompted on whether they want to play again. If they select yes another game starts with the same player/computer name
      if @@result = ["black", "black", "black", "black"]
        puts "\nCongratulations #{@player1} you cracked the code in only #{@turn_count} turns! Do you want to play again?(Yes/No)"
        rematch = gets.chomp.downcase
      
      elsif @@result.include?("white")
        puts "\nLooks like you couldn't crack the code but you were still pretty close! Do you want to play again?(Yes/No)"
        rematch= gets.chomp.downcase

      else
        puts "\nSorry #{@player1} looks like you weren't clever enough to crack the code. Do you want to try again?(Yes/No)"
        rematch = gets.chomp.downcase
      end

      if rematch == "yes"
        game_1 = Mastermind.new("#{@player1}")
        game_1.start_game
      end
    end
  end
 
    # The class for if the player wants to make a code for the computer to guess. It inherits a good bit of info from the Mastermind game class. 
class ComputerTriesToGuess < Mastermind

    # These class variables exist to hold the user created code and the result of the computers guess.
  @@user_code =
 @@result = [] 

 def computers_turn
   
    # Variables to hold the computers guesses, the colors that have not been tried, the colors that are used in the code and in the right spot, colors that are not in the code, and colors that are correct but in the wrong spot, the result of the computers guess.
  guess = []
  left_over_colors = []  
  saved_colors = []
  bad_colors = []
  viable_colors = []
  result = []
    
    # Asks the player to input a code and gives one additional chance if they make a mistake.
  puts "\nOk, #{@player1} what is your code?"
  @@user_code = gets.chomp.downcase.split()

  unless @@user_code.include?("red") || @@user_code.include?("green") || @@user_code.include?("blue") || @@user_code.include?("yellow") || @@user_code.include?("brown") || @@user_code.include?("orange") && @@user_code.length == 4 
        puts "Only type #{@@possible_codes} seperated by a space. You can repeat colors."
        @@user_code = gets.chomp.downcase.split()
      end

  puts "\n#{@player1} has created its code. Can you crack it #{@@computer}?\n"
   
    # The loop that gives the computer 12 turns to solve the code. A turn count is also included for fun.
  12.times do
  @turn_count += 1
  
    # This code executes only if @@result is not empty so essentially on every non first turn. if then chooses new colors for the code based on the last turn.
  if !@@result.empty?
    @@result.map! do |spot|
      
      if spot == "blank"
        spot = left_over_colors.sample
        
      
      elsif spot == "white" 
        spot = left_over_colors.sample
        
      
      elsif @@result == ["white", "white", "white", "white"]
        spot = viable_colors.sample
        
      else 
        spot = spot  
      end
    end

    
  puts "\n#{@@computer} thinks it is #{@@result}.\n"
  end
  
    # Allows guess to run differently on different turns as the first turn it will always be empty. If it is empty it will just pick 4 colors randomly. If not it will give @@response a new value of either black white or blank depending on the computers guess. 
  guess = @@result

  if guess.empty?
  guess = @@possible_codes.sample(4)
    puts "\n#{@@computer} thinks it is #{guess}."
  end

    i = 0
    if !guess.empty?
    @@result = guess.map do |color|

  if color == @@user_code[i] && i <= 3
    i += 1
    bad_colors.push(color)
    color = "black"
   
  elsif color != @@user_code[i] && @@user_code.include?(color) && i <= 3
    i+= 1
    viable_colors.push(color)
    color = "white"
  
  else
    i += 1
    bad_colors.push(color)
    color ="blank"

  end
end  
end

    # Will break the loop early if the computer guesses the code correctly. 
break if @@result == ["black", "black", "black", "black"] || @@result == @@user_code  

  index = 0
   
    # Based on how the guess did at guessing the code @@result is changed and colors are added to different variables based on if they can be used later on.    
  @@result.map! do |spot| 
  
    if spot == "black"
    saved_colors.push(@@user_code[index])   
    index += 1
    spot = @@user_code[index - 1]
    
  elsif spot == "white"
    index += 1
    spot = "white"
    
   else spot == "blank"
      index += 1
      spot = "blank"
      
    end
  end
 
  
   puts"\n#{@@computer} gets in response #{@@result}.\n"
  
    # At the end of each loop bad_colors is subtracted from @@possible_codes as the bad colors have been shown to not be included in the code.
  left_over_colors = @@possible_codes - bad_colors
  
end

    # Based on how the computer does it is given a different message and the player is prompted to play again. If they type Yes(or yes) the game starts over. If they type No(or no) the game ends.
if @@result == ["black", "black", "black", "black"]
        puts "\nCongratulations #{@@computer} you cracked the code in only #{@turn_count} turns! #{@player1} Do you want to play again?(Yes/No)"
        rematch = gets.chomp.downcase
      
      elsif @@result.include?("white")
        puts "\nLooks like #{@@computer} couldn't crack the code. Good job #{@player1} Do you want to play again?(Yes/No)"
        rematch= gets.chomp.downcase

      else
        puts "\nSorry #{@@computer} looks like you weren't clever enough to crack the code. #{@player1} you want to play again?(Yes/No)"
        rematch = gets.chomp.downcase
      end

      if rematch == "yes"
        game_1 = ComputerTriesToGuess.new("#{@player1}")
        game_1.computers_turn
      end
    end
  end

game_1 = Mastermind.new("Grant")
  game_1.start_game

  #game_1 = ComputerTriesToGuess.new("Kyle")
  #game_1.computers_turn
