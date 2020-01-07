class Player
  attr_reader :entry, :name
  def initialize(name)
    @entry = []
    @name = name
  end

  def enter_code
    puts 'Enter a code:'
    @entry = gets.chomp.split
  end
end
