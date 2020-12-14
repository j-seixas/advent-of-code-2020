# frozen_string_literal: true

require './utils/utils'

def input_file
  get_file('inputs/day_14.txt').map do |line|
    values = line.split(/(mask|mem)[\[ =]+(\d+)*[\] =]+([\dX]+)/).reject(&:empty?)
    if values[0] == 'mask'
      { 'inst': values[0], 'value': values[1] }
    else
      { 'inst': values[0], 'pos': values[1], 'value': format('%036b', values[2]) }
    end
  end
end

def store_memory(mem, mask, pos, value)
  res = mask.dup
  (0..35).each do |i|
    res[i] = value[i] if res[i] == 'X'
  end
  # puts "#{mask} #{pos}, #{value}, #{res}"
  mem[pos] = res
  mem
end

def part_one(input)
  mask = ''
  mem = {}
  input.each do |inst|
    if inst[:inst] == 'mask'
      mask = inst[:value]
    else
      mem = store_memory(mem, mask, inst[:pos], inst[:value])
    end
  end

  sum = 0
  mem.each do |_, v|
    sum += v.to_i(2)
  end
  sum
end

bitmask = input_file
# puts "#{bitmask}"
puts "Day 14 - Part 1 --> Sum: #{part_one(bitmask)}"
# puts "Day 14 - Part 2 --> Sum: #{part_two(bitmask)}"
