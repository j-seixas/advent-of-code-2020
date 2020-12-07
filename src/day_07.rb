# frozen_string_literal: true

require './utils/utils'
require 'active_support/core_ext/hash'
require 'set'

def input_file
  input = get_file('inputs/input_day_07.txt')
  input.map do |line|
    values = line.split(/ bags contain | bags?[., ]*|no other|(\d) /).reject(&:empty?)
    hash = { name: values[0] }
    values[1..-1].each_slice(2) do |count, name|
      hash[name] = count
    end
    hash
  end
end

def get_set_bags(input, bag_name)
  bags = input.select { |hash| hash.keys.include?(bag_name) }
  tmp = bags.map { |b| b[:name] }
  set = tmp.to_set
  tmp.each do |v|
    set.merge(get_set_bags(input, v))
  end

  set
end

def part_one(input, bag_name)
  get_set_bags(input, bag_name).size
end

def part_two(input, bag_name)
  count = 0
  bag = input.select { |hash| hash.values.include?(bag_name) }[0]
  bag.except(:name).each do |k, v|
    count += v.to_i + v.to_i * part_two(input, k)
  end
  count
end

bags = input_file
puts "Day 7 - Part 1 --> Bag colors: #{part_one(bags, 'shiny gold')}"
puts "Day 7 - Part 2 --> Bags: #{part_two(bags, 'shiny gold')}"
