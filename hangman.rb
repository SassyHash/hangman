class Hangman
  BODY_PARTS_ALLOWED = 10

  attr_reader :game_board

  def initialize
    @game_board = []
    @word_length = nil
    @wrong_guesses = 0
  end

  def play

    # secret_word = computer.pick_secret_word(load_dictionary(@dictionary_file))
    # secret_word.size.times { @game_board << "_" }
    @game_board = Array.new(@word_length , "_")

    until victory? || lynching?
    end
  end

  def victory?
    !@game_board.include?("_")
  end

  def lynching?
    BODY_PARTS_ALLOWED == @wrong_guesses
  end

  def print_board
    puts @game_board.join('')
  end
end


class Player
end


class Human < Player
end


class Computer < Player
  def initialize
    @dictionary_file = "dictionary.txt"
  end

  def get_word_length
  end

  # # Returns a secret word.  If no length is given, then a word between 
  # # 3 and 10 letters is randomly selected.
  # def pick_secret_word(word_length=(rand(3..10)))
  #   words = load_dictionary(@dictionary_file)
  #   words.select { |word| word.size == word_length }.sample
  # end

  def pick_secret_word(word_length=nil)
    words = load_dictionary(@dictionary_file)
    word_length.nil? ? words.sample : words.select { |w| w.size == word_length }.sample
  end

  def load_dictionary(filename)
    tmp_dict_array = []
    File.foreach(filename) { |word| tmp_dict_array << word.downcase.strip }
    return tmp_dict_array
  end
end