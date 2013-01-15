class Hangman
  BODY_PARTS_ALLOWED = 10

  attr_reader :game_board

  def initialize
    @game_board = []
    @word_length = nil
    @game_host
    @wrong_guesses = 0
  end

  def play
    if pick_guesser == "H" # human guesser
      # create computer
      @game_host = Computer.new
      # pick a word
      @game_host.pick_secret_word
      # create the board
      @game_board = Array.new(@game_host.secret_word.size, "_")

      # start guess loop
      let_human_guess

      if victory? 
        puts "You won, NICE!"
      else
        puts "You lose, BE SAD."
      end
    else # computer guesser
    end
  end

  def let_human_guess
    puts "Secret word: #{@game_board}"
    print "> "

    # Whatever crap they give us, just take the first letter
    letter = gets.chomp.split(//).first

    # Update the board
    secret_word_letters = @game_host.secret_word.split(//)
    secret_word_letters.each_with_index do |el, i|
      @game_board[i] = letter if el == letter
    end

    let_human_guess unless (victory? || lynching?)
  end

  def pick_guesser
    guesser = nil
    while guesser != "H" && guesser != "C"
      puts "Who's going to guess? (C)omputer or (H)uman"
      guesser = gets.chomp.upcase
    end
    guesser
  end

  def victory?
    !@game_board.include?("_")
  end

  def lynching?
    BODY_PARTS_ALLOWED == @wrong_guesses
  end

  def board
    @game_board.join('')
  end
end


class Player
end


class Human < Player
end


class Computer < Player
  attr_accessor :secret_word

  def initialize
    @dictionary_file = "dictionary.txt"
    @secret_word = nil
  end

  # def word_length
  #   @secret_word.size
  # end

  # # Returns a secret word.  If no length is given, then a word between 
  # # 3 and 10 letters is randomly selected.
  # def pick_secret_word(word_length=(rand(3..10)))
  #   words = load_dictionary(@dictionary_file)
  #   words.select { |word| word.size == word_length }.sample
  # end

  def pick_secret_word(word_length=nil)
    words = load_dictionary(@dictionary_file)
    @secret_word = word_length.nil? ? words.sample : words.select { |w| w.size == word_length }.sample
  end

  def load_dictionary(filename)
    tmp_dict_array = []
    File.foreach(filename) { |word| tmp_dict_array << word.downcase.strip }
    return tmp_dict_array
  end
end