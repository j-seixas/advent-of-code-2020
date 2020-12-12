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
    [position[0], position[1] + value]
  when 'S'
    [position[0], position[1] - value]
  when 'E'
    [position[0] + value, position[1]]
  when 'W'
    [position[0] - value, position[1]]
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
      position = [position[1], -position[0]]
    when 'L'
      position = [-position[1], position[0]]
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
  position = [0, 0] # x,y -> east, north
  input.each do |inst|
    position, direction = process_instruction(inst, position, direction)
  end
  position[0].abs + position[1].abs
end

def part_two(input, waypoint)
  position = [0, 0] # x,y -> east, north
  input.each do |inst|
    case inst[:inst]
    when 'F'
      position = [position[0] + inst[:value] * waypoint[0], position[1] + inst[:value] * waypoint[1]]
    when 'R', 'L'
      waypoint = rotate_waypoint(waypoint, inst[:inst], inst[:value])
    when 'N', 'S', 'E', 'W'
      waypoint = move(inst[:inst], waypoint, inst[:value])
    end
  end
  position[0].abs + position[1].abs
end

instructions = input_file
puts "Day 12 - Part 1 --> Distance: #{part_one(instructions, 'E')}"
puts "Day 12 - Part 2 --> Distance: #{part_two(instructions, [10, 1])}"
