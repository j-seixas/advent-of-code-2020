# frozen_string_literal: true

require './utils/utils'

def input_file
  get_file('inputs/day_10.txt').map(&:to_i).sort
end

def part_one(input, outlet = 0)
  differences = [0, 0, 1]
  old = outlet
  input.each do |value|
    diff = value - old
    return false unless diff.positive? && diff <= 3

    differences[diff - 1] += 1
    old = value
  end

  differences.reject(&:zero?).inject(:*)
end

adapters = input_file
puts "Day 10 - Part 1 --> Joltage differences multiplied: #{part_one(adapters, 0)}"
# puts "Day 10 - Part 2 --> Joltage: #{part_two(adapters, 0)}"
