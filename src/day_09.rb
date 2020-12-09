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
    return value, i unless found
  end
end

def part_two(input, preamble_size)
  value, index = part_one(input, preamble_size)
  return unless index

  start = 0
  index_end = 0
  while start < index
    sum = 0
    input[start..index - 1].each_with_index do |v, i|
      sum += v
      if sum == value
        index_end = start + i
        break
      elsif sum > value
        break
      end
    end
    break if index_end != 0

    start += 1
  end

  input[start..index_end].max + input[start..index_end].min
end

xmas = input_file
puts "Day 9 - Part 1 --> First incorrect: #{part_one(xmas, 25)[0]}"
puts "Day 9 - Part 2 --> Weakness: #{part_two(xmas, 25)}"
