# frozen_string_literal: true

require './utils/utils'

def input_file
  get_file('inputs/day_02.txt').map do |policy|
    splitted = policy.split(' ')
    {
      min: splitted[0].split('-')[0].to_i,
      max: splitted[0].split('-')[1].to_i,
      word: splitted[1].gsub(':', ''),
      password: splitted[2]
    }
  end
end

def part_one(passwords)
  total = 0
  passwords.each do |password|
    count = password[:password].count(password[:word])
    total += 1 if count >= password[:min] && count <= password[:max]
  end

  total
end

def part_two(passwords)
  total = 0
  passwords.each do |password|
    first = password[:password][password[:min] - 1]
    second = password[:password][password[:max] - 1]
    total += 1 if (first == password[:word] && second != password[:word]) ||
                  (first != password[:word] && second == password[:word])
  end

  total
end

passwords = input_file
puts "Day 2 - Part 1 --> total: #{part_one(passwords)}"
puts "Day 2 - Part 2 --> total: #{part_two(passwords)}"
