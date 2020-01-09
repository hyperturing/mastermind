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
