# frozen_string_literal: true

require './utils/utils'

def input_file
  get_file('inputs/input_day_09.txt').map(&:to_i)
end

def part_one(input, preamble_size)
  return if input.size <= preamble_size

  input.each_with_index do |value, i|
    next if i <= preamble_size

    tmp = input[i - preamble_size..i]
    found = false
    tmp.each do |v|
      found = true if tmp.include?(value - v)
    end
    return value unless found
  end
end

xmas = input_file
puts "Day 9 - Part 1 --> First incorrect: #{part_one(xmas, 25)}"
# puts "Day 9 - Part 2 --> : #{part_two(xmas)}"
