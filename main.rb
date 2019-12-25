# frozen_string_literal: true
require_relative 'game'

game = Game.new

until game.complete? do game.play_round end

game.end_game
