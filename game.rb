class Game
  require_relative 'player'
  require_relative 'board'
  attr_reader :round

  def initialize
    puts 'Welcome to Mastermind!!'
    @player = Player.new
    @board = Board.new
    @round = 1

    puts "Instructions:\n\n"
    puts '========================'
    puts 'Out of six possible colors,'
    puts 'The secret code is a four color sequence (separated by spaces)'
    puts "When prompted, enter your guess for the secret code\n\n"
    puts "Correct guess legend:\n\n"
    puts '[]: Correct value right position'
    puts "@: Correct value wrong position\n\n"
  end

  def play_round
    puts '%%%%%% Your Turn%%%%%%%%'
    puts

    until @board.validated_guess?(@player.guess_code) do @player.guess_code end
    @round += 1
  end

  def complete?
    @board.correct_guess?(@player.guess) || @round == 9
  end

  def end_game
    puts @correct ? 'You won!' : 'You lost!'
  end
end
