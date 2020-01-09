module Score
  def self.calculate_score(guess, code_size, code)
    number_correct = number_wrong_position = 0
    # Determine the number of elements in the correct position
    number_correct = guess.zip(code).count do |guess_elem, code_elem|
      guess_elem == code_elem
    end

    # Determine the number of elements in the wrong position but correct value
    if number_correct < code_size - 1
      number_wrong_position = guess.sort.zip(code).count do |guess_elem, code_elem|
        guess_elem == code_elem
      end
    end
    [number_correct, number_wrong_position]
  end
end
