module Score
  def self.score(entry, code_size, code = @code)
    number_correct = number_wrong_position = 0
    # Determine the number of elements in the correct position
    number_correct = entry.zip(code).count do |entry_elem, code_elem|
      entry_elem == code_elem
    end

    # Determine the number of elements in the wrong position but correct value
    if number_correct < code_size - 1
      number_wrong_position = entry.sort.zip(code).count do |entry_elem, code_elem|
        entry_elem == code_elem
      end
    end
    [number_correct, number_wrong_position]
  end
end
