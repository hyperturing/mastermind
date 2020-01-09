# frozen_string_literal: true

# Player class - Being playing our mastermind game
###################################################################
# Constructor Parameters:
# name (string)
##########
# Fields:
###
# Name: Name of the player
# guess: string array of our mastermind guess
# Score: integer array of the mastermind score for this guess
# Methods :
###
# enter_code:
#   Returns our player's guess of the secret code
###################################################################
class Player
  attr_reader :guess, :name
  attr_accessor :score

  def initialize(name)
    @guess = []
    @name = name
  end

  def enter_code
    puts 'Enter a code:'
    @guess = gets.chomp.split
  end
end
