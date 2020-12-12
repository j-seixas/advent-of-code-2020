# frozen_string_literal: true

require './utils/utils'

def input_file
  input = get_file('inputs/day_12.txt')
  input.map do |line|
    values = line.split(/([FNSEWLR])(\d+)/).reject(&:empty?)
    {
      inst: values[0],
      value: values[1].to_i
    }
  end
end

def move(direction, position, value)
  case direction
  when 'N'
    [position[0] + value, position[1]]
  when 'S'
    [position[0] - value, position[1]]
  when 'E'
    [position[0], position[1] + value]
  when 'W'
    [position[0], position[1] - value]
  end
end

def rotate(direction, value)
  value /= 90
  directions = %w[N E S W]
  directions[(directions.find_index(direction) + value) % 4]
end

def process_instruction(instruction, position, direction)
  case instruction[:inst]
  when 'F'
    [move(direction, position, instruction[:value]), direction]
  when 'N', 'S', 'E', 'W'
    [move(instruction[:inst], position, instruction[:value]), direction]
  when 'R'
    [position, rotate(direction, instruction[:value])]
  when 'L'
    [position, rotate(direction, -instruction[:value])]
  end
end

def part_one(input, direction)
  north_east = [0, 0]
  input.each do |inst|
    north_east, direction = process_instruction(inst, north_east, direction)
  end
  north_east[0].abs + north_east[1].abs
end

instructions = input_file
puts "Day 12 - Part 1 --> Distance: #{part_one(instructions, 'E')}"
# puts "Day 12 - Part 2 --> Distance: #{part_two(instructions)}"
