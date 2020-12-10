# frozen_string_literal: true

require './utils/utils'
require 'set'

def input_file
  get_file_unprocessed('inputs/day_06.txt').split("\n\n").map do |group|
    tmp = group.split("\n")
    {
      count: tmp.size,
      group: tmp.join('')
    }
  end
end

def count_unique(values)
  values.chars.to_set.count
end

def count_shared_unique(values)
  values[:group].each_char.tally.select { |_, v| v == values[:count] }.size
end

def part_one(input, count = 0)
  input.each do |v|
    count += count_unique(v[:group])
  end
  count
end

def part_two(input, count = 0)
  input.each do |v|
    count += count_shared_unique(v)
  end
  count
end

answers = input_file
puts "Day 6 - Part 1 --> Sum 'yes': #{part_one(answers)}"
puts "Day 6 - Part 2 --> Sum 'yes' shared: #{part_two(answers)}"
