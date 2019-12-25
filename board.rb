class Board
  attr_reader :legend, :guess
  CODE_SIZE = 4
  COLORS = %w[blue orange purple green red yellow].freeze
  def initialize
    @code = CODE_SIZE.times.reduce([]) { |output| output << COLORS.sample }
  end

  def display_board(guess, number_correct, number_wrong_position)
    puts "\n======The Board========"
    guess.each { |element| print " #{element} " }
    print ' | '
    number_correct.times { print ' [] ' }
    number_wrong_position.times { print ' @ ' }
    puts "\n\n"
    puts '======================='
  end

  def validated_guess?(guess)
    display_board(@code, 0, 0) if guess == ['debug']
    guess.length == 4
  end

  def correct_guess?(guess)
    # Determine the number of elements in the correct position
    @number_correct = guess.zip(@code).count do |guess_elem, code_elem|
      guess_elem == code_elem
    end

    # Determine the numher of elements in the wrong position but correct value
    @number_wrong_position = guess.sort.zip(@code).count do |guess_elem, code_elem|
      guess_elem == code_elem
    end

    display_board(guess, @number_correct, @number_wrong_position)

    @correct == @code.length
  end
end
