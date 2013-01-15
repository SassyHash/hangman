class Hangman
  BODY_PARTS_ALLOWED = 10

  attr_reader :dictionary_file, :secret_word, :game_board

  def initialize
  	@dictionary_file = "dictionary.txt"
    @game_board = []
    @word_length = nil
  end

  def play
    # If human = guesser
    computer = Computer.new

    secret_word = computer.pick_secret_word(load_dictionary(@dictionary_file))
    # secret_word.size.times { @game_board << "_" }
    @game_board = Array.new(@word_length , "_")

    until victory? || lynching?
    end
  end

  def load_dictionary(filename)
    tmp_dict_array = []
    File.foreach(filename) { |word| tmp_dict_array << word.downcase.strip }
    return tmp_dict_array
  end

  def victory?
    @game_board == @secret_word
  end

  def lynching?
    @game_board.size == BODY_PARTS
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
  def pick_secret_word(dictionary)
    dictionary.sample
  end
end