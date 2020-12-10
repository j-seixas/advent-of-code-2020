# frozen_string_literal: true

require './utils/utils'

def input_file
  get_file('inputs/day_03.txt')
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

def part_two(input, steps, pos = [0, 0])
  total = 1
  steps.each { |step| total *= part_one(input, step, pos.dup) }

  total
end

input = input_file
puts "Day 3 - Part 1 --> Trees: #{part_one(input, [3, 1])}"
puts "Day 3 - Part 2 --> Trees multiplied: #{part_two(input, [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]])}"
