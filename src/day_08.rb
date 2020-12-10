# frozen_string_literal: true

require './utils/utils'

def input_file
  input = get_file('inputs/day_08.txt')
  input.map do |line|
    values = line.split(/(acc|nop|jmp) (-|\+)(\d+)/).reject(&:empty?)
    {
      name: values[0],
      value: values[1] == '+' ? values[2].to_i : 0 - values[2].to_i
    }
  end
end

def deep_copy(array)
  array.map(&:dup)
end

def part_two(input, value1, value2)
  input.each_with_index do |line, i|
    next unless [value1, value2].include?(line[:name])

    tmp_input = deep_copy(input)
    case line[:name]
    when value1
      tmp_input[i][:name] = value2
    when value2
      tmp_input[i][:name] = value1
    end

    finished, count = part_one(tmp_input)
    return count if finished
  end
  false
end

def part_one(input, count = 0)
  i = 0
  while i < input.size
    return false, count if input[i]['visited']

    input[i]['visited'] = true
    case input[i][:name]
    when 'acc'
      count += input[i][:value]
      i += 1
    when 'jmp'
      i += input[i][:value]
    when 'nop'
      i += 1
    end
  end
  [true, count]
end

instructions = input_file
puts "Day 8 - Part 1 --> Accumulator: #{part_one(deep_copy(instructions))[1]}"
puts "Day 8 - Part 2 --> Accumulator: #{part_two(deep_copy(instructions), 'nop', 'jmp')}"
