# frozen_string_literal: true

require './utils'

def input_file
  get_file('inputs/input_day_03.txt')
end

def value_at(input, index)
  input[index % input.length]
end

def part_one(input, step, pos = [0, 0])
  total = 0
  while pos.last < input.size
    total += 1 if value_at(input[pos.last], pos.first) == '#'
    pos[0] += step.first
    pos[1] += step.last
  end

  total
end

# def part_two(input)
#   total = 0
#   passwords.each do |password|
#     first = password[:password][password[:min] - 1]
#     second = password[:password][password[:max] - 1]
#     total += 1 if (first == password[:word] && second != password[:word]) ||
#                   (first != password[:word] && second == password[:word])
#   end

#   total
# end

input = input_file
puts "Day 3 - Part 1 --> Trees: #{part_one(input, [3, 1])}"
# puts "Day 2 - Part 2 --> total: #{part_two(passwords)}"
