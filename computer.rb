# frozen_string_literal: true

require_relative 'board'
require_relative 'utils'
require 'set'

# Citation:
################
# RubyConf 2018:
# Beating Mastermind: Winning with the help of Donald Knuth by Adam Forsyth
# http://confreaks.tv/videos/rubyconf2018-beating-mastermind-winning-with-the-help-of-donald-knuth

# COMPUTER Player class - Mastermind Guessing AI
##################################################################
# Constructor Parameters:
# name (string), colors (array), code_size (integer)
##########
# Accessible Fields:
# score: A integer array of the mastermind score of our previous guess
##########
# Methods:
###
# enter_code:
#   Returns a 1122 guess or a guess based on our previous guess:
#     Our guess is a 3-element array of:
#       The maximum number of possible scores for this guess
#       A boolean indicating an impossible guess
#       Our guess itself
#######################################################################
class Computer < Player
  attr_reader :colors, :code_size
  attr_accessor :score

  def initialize(name, colors = '', code_size = 4)
    super(name)
    @code_size = code_size
    @guesses = 0
    # Create a hash to hold all possible scores to all possible guesses
    @all_scores = Hash.new { |h, k| h[k] = {} }
    @all_answers = colors.repeated_permutation(code_size).to_a

    @all_answers.product(@all_answers).each do |guess, answer|
      @all_scores[guess][answer] = Utils.calculate_score(guess, @code_size, answer)
    end
    @all_answers = @all_answers.to_set

    @possible_scores = @all_scores.dup
    @possible_answers = @all_answers.dup
  end

  def enter_code
    # Minimax algorithm ahead

    # Keep only possible answers that would match our previous answer's score
    if @guesses.positive?
      @possible_answers.keep_if do |answer|
        @all_scores[@guess][answer] == score
      end

      guesses = @possible_scores.map do |guess, scores_by_answer|
        # Keep only possible scores from guesses that include our answer
        scores_by_answer = scores_by_answer.select do |answer, _score|
          @possible_answers.include?(answer)
        end
        @possible_scores[guess] = scores_by_answer

        # Group each possible score for our guess
        #   Keep track of how many times it appears
        #   Our worst case for this guess is the largest group
        score_groups = scores_by_answer.values.group_by(&:itself)
        possibility_counts = score_groups.values.map(&:length)
        worst_case_possibility = possibility_counts.max

        # Is this guess impossible given our possible answers?
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
