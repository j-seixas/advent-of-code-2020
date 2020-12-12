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

def rotate_waypoint(position, direction, value)
  (90..value).step(90).each do |_|
    case direction
    when 'R'
      position = [-position[1], position[0]]
    when 'L'
      position = [position[1], -position[0]]
    end
  end
  position
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

def part_two(input, waypoint)
  north_east = [0, 0]
  input.each do |inst|
    case inst[:inst]
    when 'F'
      north_east = [north_east[0] + inst[:value] * waypoint[0], north_east[1] + inst[:value] * waypoint[1]]
    when 'R', 'L'
      waypoint = rotate_waypoint(waypoint, inst[:inst], inst[:value])
    when 'N', 'S', 'E', 'W'
      waypoint = move(inst[:inst], waypoint, inst[:value])
    end
  end
  north_east[0].abs + north_east[1].abs
end

instructions = input_file
puts "Day 12 - Part 1 --> Distance: #{part_one(instructions, 'E')}"
puts "Day 12 - Part 2 --> Distance: #{part_two(instructions, [1, 10])}"
