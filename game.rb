class Game
  require_relative 'player'
  require_relative 'board'
  require_relative 'computer'
  require_relative 'utils'
  attr_reader :round

  COLORS = %w[blue orange purple green red yellow].freeze
  CODE_SIZE = 4

  def initialize
    puts instructions
    if Utils.ask_yes_no_question('Do you wish to be the codemaster? ')
      puts "\n\nInitializing AI, please be patient"
      puts "They have a lot on their mind\n\n"
      @codebreaker = Computer.new('Ash 2.0', COLORS, CODE_SIZE)
      @codemaker = Player.new('Ash')
      @code = @codemaker.enter_code
    else
      @codebreaker = Player.new('Ash')
      @codemaker = Computer.new('Ash 2.0')
      @code = CODE_SIZE.times.reduce([]) { |output| output << COLORS.sample }
    end

    @board = Board.new(@code, COLORS, CODE_SIZE)
    @round = 1
  end

  def play_round
    puts "Round #{round}"
    puts "%%%%%% #{@codebreaker.name}'s' Turn%%%%%%%%"
    @codebreaker.score = @board.evaluate_guess(@codebreaker.enter_code)
    @board.display_board
    @round += 1
    puts "Press any key to go to the next round"
    gets.chomp
  end

  def complete?
    @board.correct_guess? || @round == 12
  end

  def end_game
    @codebreaker.name.to_s + (@board.winner? ? ' won!' : ' lost!')
  end

  def instructions
    ["Welcome to Mastermind!!\n",
     "Instructions:\n\n",
     '========================',
     'Out of six possible colors,',
     'The secret code is a four color sequence (separated by spaces)',
     '=========================',
     'Instructions for guesser:',
     '==========================',
     "When prompted, enter your guess for the secret code\n\n",
     "Correct guess legend:\n\n",
     '[]: Correct value right position',
     "@: Correct value wrong position\n\n",
     '================================',
     'Instructions for codemaker:',
     '==============================',
     'When prompted, enter a four color sequence for the secret code'].join("\n") + "\n"
  end

  def enter_code
    until @board.validated?(@player.guess)
      puts 'Invalid code format'
      @player.enter_code
    end
    @player.entry
  end
end
