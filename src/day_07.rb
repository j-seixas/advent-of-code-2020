# frozen_string_literal: true

require './utils/utils'

def input_file
  input = get_file('inputs/input_day_07.txt')
  input.map do |line|
    values = line.split(/ bags contain | bags?[., ]*|(\d) /).reject(&:empty?)
    hash = { name: values[0] }
    values[1..-1].each_slice(2) do |count, name|
      hash[name] = count
    end
    hash
  end
end

bags = input_file
#puts "Day 7 - Part 1 --> Bag colors: #{part_one(bags, 'shiny gold')}"
# puts "Day 7 - Part 2 --> Bags: #{part_two(bags)}"
