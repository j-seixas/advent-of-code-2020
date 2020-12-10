# frozen_string_literal: true

require './utils/utils'

def input_file
  get_file('inputs/day_01.txt').map(&:to_i)
end

def part_one(values, objective)
  values.each_with_index do |value, index|
    values[(index + 1)..-1].each do |v|
      return value, v, v * value if value + v == objective
    end
  end
end

def part_two(values, objective)
  input_file.each_with_index do |value, index|
    values[(index + 1)..-1].each_with_index do |v, i|
      values[(i + 1)..-1].each do |j|
        return value, v, j, v * value * j if value + v + j == objective
      end
    end
  end
end

def part_one_revamp(values, objective)
  values.each do |value|
    second_value = objective - value
    next unless second_value.positive?

    return value, second_value, value * second_value if values.include?(second_value)
  end

  nil
end

def part_two_revamp(values, objective)
  values.each_with_index do |value, index|
    second_objective = objective - value
    second, third, r = part_one_revamp(values[(index + 1)..-1], second_objective)
    return value, second, third, r * value if second
  end
end

values = input_file
objective = 2020

v1, v2, r = part_one(values, objective)
puts "Day 2 - Part 1 --> #{v1} + #{v2} = #{objective}, #{v1} * #{v2} = #{r}"

v1, v2, v3, r = part_two(values, objective)
puts "Day 2 - Part 2 --> #{v1} + #{v2} + #{v3} = #{objective}, #{v1} * #{v2} * #{v3} = #{r}"

v1, v2, r = part_one_revamp(values, objective)
puts "Day 2 - Part 1 revamped --> #{v1} + #{v2} = #{objective}, #{v1} * #{v2} = #{r}"

v1, v2, v3, r = part_two_revamp(values, objective)
puts "Day 2 - Part 2 revamped --> #{v1} + #{v2} + #{v3} = #{objective}, #{v1} * #{v2} * #{v3} = #{r}"
