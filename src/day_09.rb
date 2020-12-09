# frozen_string_literal: true

require './utils/utils'

def input_file
  get_file('inputs/input_day_09.txt').map(&:to_i)
end

def part_one(input, preamble_size)
  return if input.size <= preamble_size

  input[preamble_size..-1].each_with_index do |value, i|
    tmp = input[i..i + preamble_size]
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
  while start < index - 1
    sum = 0
    input[start..index - 1].each_with_index do |v, i|
      sum += v
      return input[start..start + i].max + input[start..start + i].min if sum == value
      break if sum > value
    end
    break if index_end != 0

    start += 1
  end

  false
end

xmas = input_file
puts "Day 9 - Part 1 --> First incorrect: #{part_one(xmas, 25)[0]}"
puts "Day 9 - Part 2 --> Weakness: #{part_two(xmas, 25)}"
