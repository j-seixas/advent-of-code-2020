# frozen_string_literal: true

require './utils/utils'

def input_file
  get_file('inputs/day_11.txt').map { |line| line.split '' }
end

def ocupied_adjacent(input, i, j)
  count = 0
  (i - 1..i + 1).each do |l|
    next if l.negative? || l >= input.size

    (j - 1..j + 1).each do |c|
      next if c.negative? || c >= input[l].size || (i == l && j == c)

      count += 1 if input[l][c] == '#'
    end
  end
  count
end

def iterate(input)
  change = false
  final = deep_copy(input)
  input.each_with_index do |line, i|
    line.each_with_index do |column, j|
      ocupied = ocupied_adjacent(input, i, j)
      if column == 'L' && ocupied.zero?
        final[i][j] = '#'
        change = true
      elsif column == '#' && ocupied >= 4
        final[i][j] = 'L'
        change = true
      end
    end
  end
  [change, final]
end

def part_one(input)
  change = true
  iter_input = input
  change, iter_input = iterate(iter_input) while change
  count = 0
  iter_input.each do |v|
    count += v.count('#')
  end
  count
end

seat_layout = input_file
puts "Day 11 - Part 1 --> Seats ocupied: #{part_one(seat_layout)}"
# puts "Day 11 - Part 2 --> Seats ocupied: #{part_two(seat_layout)}"
