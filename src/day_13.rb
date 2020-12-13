# frozen_string_literal: true

require './utils/utils'

def input_file
  input = get_file_unprocessed('inputs/day_13.txt').split("\n")
  buses = input[1].split(',').map do |value|
    value == 'x' ? value : value.to_i
  end
  [input[0].to_i, buses]
end

def part_one(time, input)
  minimum = time
  best_bus = nil
  input.each do |bus|
    next if bus == 'x'

    wait = (time + bus) % bus
    wait = wait.zero? ? wait : bus - wait
    if wait < minimum
      minimum = wait
      best_bus = bus
    end
    break if minimum.zero?
  end
  puts " #{best_bus}, #{minimum}"
  best_bus * minimum
end

time, buses = input_file
# puts " #{time}, #{buses}"
puts "Day 13 - Part 1 --> ID x wait: #{part_one(time, buses)}"
# puts "Day 13 - Part 2 --> Distance: #{part_two(buses)}"
