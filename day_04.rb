# frozen_string_literal: true

require './utils'

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

def validate_year(value, lower, higher)
  match_regex?(value, /^[0-9]{4}$/) && value.to_i >= lower && value.to_i <= higher
end

def validate_hgt(value)
  if value.include? 'in'
    value.sub('in', '').to_i >= 59 && value.sub('in', '').to_i <= 76
  elsif value.include? 'cm'
    value.sub('cm', '').to_i >= 150 && value.sub('cm', '').to_i <= 193
  else
    false
  end
end

def validate_hcl(value)
  match_regex?(value, /^#[a-f0-9]{6}$/)
end

def validate_ecl(value)
  %w[amb blu brn gry grn hzl oth].include?(value)
end

def validate_pid(value)
  match_regex?(value, /^[0-9]{9}$/)
end

def valid(value)
  validate_year(value['byr'], 1920, 2002) && validate_year(value['iyr'], 2010, 2020) &&
    validate_year(value['eyr'], 2020, 2030) && validate_hgt(value['hgt']) && validate_hcl(value['hcl']) &&
    validate_ecl(value['ecl']) && validate_pid(value['pid'])
end

def part_one(input, ignore = nil)
  values = %w[byr iyr eyr hgt hcl ecl pid cid] - ignore
  count = 0
  input.each { |v| count += (values - v.keys).empty? ? 1 : 0 }
  count
end

def part_two(input, ignore = nil)
  values = %w[byr iyr eyr hgt hcl ecl pid cid] - ignore
  count = 0
  input.each do |v|
    next unless (values - v.keys).empty?

    count += 1 if valid v
  end
  count
end

passports = input_file
puts "Day 4 - Part 1 --> Passports: #{part_one(passports, ['cid'])}"
puts "Day 4 - Part 2 --> Passports: #{part_two(passports, ['cid'])}"
