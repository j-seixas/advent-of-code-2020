# frozen_string_literal: true

require './utils'

$passport_values = %w[byr iyr eyr hgt hcl ecl pid cid]

def input_file(index = 0, result = [])
  input = get_file('inputs/input_day_04.txt')
  input.each do |line|
    if line.empty?
      index += 1
      next
    end
    v = line.split.map { |l| l.split(':') }.to_h
    result[index] = result[index].nil? ? v : result[index].merge(v)
  end

  result
end

def part_one(input, ignore = nil)
  values = $passport_values - ignore
  count = 0
  input.each { |v| count += (values - v.keys).empty? ? 1 : 0}
  count
end

passports = input_file
puts "Day 4 - Part 1 --> Passports: #{part_one(passports, ignore = ['cid'])}"
