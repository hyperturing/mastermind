# frozen_string_literal: true

# Board class - Mastermind Board
###################################################################
# Constructor Parameters: code (array), colors (array), code_size (integer)
##########
# Fields:
###
# code: An array of strings that holds our secret code
# colors: An array of strings of valid mastermind colors
# guess: An array of strings that holds our guess of the secret code
# correct: a boolean indicating if the guess was correct
##########
# Methods:
###
# display_board :
#   formats and displays our board and displays it to output
# validated? :
#   returns a boolean indicating if our entry was a valid code
# correct_guess? :
#   returns a boolean indicating if our guess matches the secret code
# winner? :
#   returns a boolean indicating if our player won the game
# evaluate_guess:
#   return a mastermind score for a given guess of our secret code
#########################################################################
class Board
  attr_reader :guess, :colors

  def initialize(code, colors, code_size)
    @code = code
    @colors = colors
    @code_size = code_size
  end

  def display_board
    @number_correct, @number_wrong_position = @score
    puts "\n===========The Board==========="
    @guess.each { |element| print " #{element} " }
    print ' | '
    @number_correct.times { print ' [] ' }
    @number_wrong_position.times { print ' @ ' }
    puts "\n\n"
    puts '======================='
  end

  def validated?(entry)
    entry.length == 4 && entry.all? { |element| colors.include?(element) }
  end

  def correct_guess?
    @correct = @number_correct == @code.length
  end

  def winner?
    @correct
  end

  def evaluate_guess(guess, code = @code)
    @guess = guess
    @score = Utils.calculate_score(@guess, @code_size, code)
  end
end
