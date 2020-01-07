# frozen_string_literal: true

require_relative 'board'
require_relative 'score'

class Computer < Player
  attr_reader :colors, :code_size

  def initialize(name, colors = '', code_size = 4)
    super(name)
    @colors = colors.freeze
    @code_size = code_size
    @token_pool = @guess_pool = colors.repeated_permutation(code_size).to_a
  end

  def enter_code
    @entry = @token_pool[0]
  end

  def train(answer)
    @answer = answer
    @token_pool.delete_if { |token| Score.score(token, code_size, @entry) != answer }
  end
end
