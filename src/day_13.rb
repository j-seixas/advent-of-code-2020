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
  best_bus * minimum
end

# brute force not working
def part_two(input)
  found = false
  cleaned = input.each_with_index.map { |v, i| [v, i] unless v == 'x' }.compact
  iter = cleaned.map(&:first).max
  index = cleaned.map(&:first).find_index(iter)
  t = iter
  until found
    t += iter
    puts "#{t}"
    found = true
    v = t - index
    cleaned.each do |bus, i|
      if (v + i) % bus != 0
        found = false
        break
      end
    end
  end
  t
end

time, buses = input_file
puts " #{time}, #{buses}"
puts "Day 13 - Part 1 --> ID x wait: #{part_one(time, buses)}"
puts "Day 13 - Part 2 --> Distance: #{part_two(buses)}"