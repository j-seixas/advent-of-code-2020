# frozen_string_literal: true

require './utils'

def input_file
  get_file('inputs/input_day_01.txt').map(&:to_i)
end

def part_one(values)
  values.each_with_index do |value, index|
    values[(index + 1)..-1].each do |v|
      return [value, v, (v * value)] if value + v == 2020
    end
  end
end

def part_two(values)
  input_file.each_with_index do |value, index|
    values[(index + 1)..-1].each_with_index do |v, i|
      values[(i + 1)..-1].each do |j|
        return [value, v, j, (v * value * j)] if value + v + j == 2020
      end
    end
  end
end

values = input_file
v1, v2, r = part_one(values)
puts "Day 2 - Part 1 --> #{v1} + #{v2} = 2020, #{v1} * #{v2} = #{r}"

v1, v2, v3, r = part_two(values)
puts "Day 2 - Part 2 --> #{v1} + #{v2} + #{v3} = 2020, #{v1} * #{v2} * #{v3} = #{r}"
