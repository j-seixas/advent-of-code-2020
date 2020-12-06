# frozen_string_literal: true

require './utils/utils'
require 'set'

def input_file
  get_file_unprocessed('inputs/input_day_06.txt').split("\n\n").map { |group| group.gsub("\n", '') }
end

def count_unique(values)
  values.chars.to_set.count
end

def part_one(input, count = 0)
  input.each do |v|
    count += count_unique(v)
  end
  count
end

answers = input_file
puts "Day 6 - Part 1 --> Sum 'yes': #{part_one(answers)}"
# puts "Day 6 - Part 2 --> : #{part_two(answers)}"
