class Board
  attr_reader :legend, :guess, :correct, :colors

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

  def evaluate_guess(guess, code = @code)
    @guess = guess
    @score = Score.calculate_score(@guess, @code_size, code)
  end
end
