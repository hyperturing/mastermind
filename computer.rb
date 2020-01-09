# frozen_string_literal: true

require_relative 'board'
require_relative 'score'
require 'set'

class Computer < Player
  attr_reader :colors, :code_size

  def initialize(name, colors = '', code_size = 4)
    super(name)
    @colors = colors.freeze
    @code_size = code_size
    @guesses = 0

    # Citation:
    # RubyConf 2018 Beating Mastermind: Winning with the help of Donald Knuth by Adam Forsyth
    # Create a hash to hold all possible scores to all possible guesses
    @all_scores = Hash.new { |h, k| h[k] = {} }
    @all_answers = colors.repeated_permutation(code_size).to_a

    @all_answers.product(@all_answers).each do |guess, answer|
      @all_scores[guess][answer] = Score.calculate_score(guess, @code_size, answer)
    end
    @all_answers = @all_answers.to_set

    @possible_scores = @all_scores.dup
    @possible_answers = @all_answers.dup
  end

  def enter_code
    # Citation:
    # RubyConf 2018 Beating Mastermind: Winning with the help of Donald Knuth by Adam Forsyth
    # Minimax algorithm ahead

    # Keep only possible answers that would match our previous answer's score2
    if @guesses.positive?
      @possible_answers.keep_if do |answer|
        @all_scores[@guess][answer] == @score
      end

      guesses = @possible_scores.map do |guess, scores_by_answer|
        scores_by_answer = scores_by_answer.select do |answer, _score|
          @possible_answers.include?(answer)
        end
        @possible_scores[guess] = scores_by_answer

        score_groups = scores_by_answer.values.group_by(&:itself)
        possibility_counts = score_groups.values.map(&:length)
        worst_case_possibility = possibility_counts.max
        impossible_guess = @possible_answers.include?(guess) ? 0 : 1
        [worst_case_possibility, impossible_guess, guess]
      end
      @guess = guesses.min.last
    else
      @guess = %w[blue blue orange orange]
    end
    @guesses += 1
    @guess
  end
end
