class Player
  attr_reader :guess
  def initialize
    @guess = []
  end

  def guess_code
    puts 'Enter your guess:'
    @guess = gets.chomp.split
  end
end
