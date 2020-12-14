# frozen_string_literal: true

require './utils/utils'

def input_file
  get_file('inputs/day_14.txt').map do |line|
    values = line.split(/(mask|mem)[\[ =]{1}(\d+)*[\] =]+([\dX]+)/).reject(&:empty?)
    if values[0] == 'mask'
      { 'inst': values[0], 'value': values[1] }
    else
      { 'inst': values[0], 'pos': values[1], 'value': values[2] }
    end
  end
end

def store_memory(mem, mask, pos, value)
  res = mask.dup
  (0..35).each do |i|
    res[i] = value[i] if res[i] == 'X'
  end
  mem[pos] = res
  mem
end

def iterate(mem, pos, value)
  index = pos.index('X')
  if index.nil?
    mem[pos.to_i(2).to_s] = value
  else
    mem = iterate(mem, pos.sub('X', '0'), value)
    mem = iterate(mem, pos.sub('X', '1'), value)
  end

  mem
end

def store_memory_v2(mem, mask, pos, value)
  res = mask.dup
  (0..35).each do |i|
    res[i] = pos[i] if res[i] == '0'
  end
  iterate(mem, res, value)
end

def part_one(input, part_two = false)
  mask = ''
  mem = {}
  input.each do |inst|
    if inst[:inst] == 'mask'
      mask = inst[:value]
    elsif part_two
      store_memory_v2(mem, mask, format('%036b', inst[:pos]), inst[:value].to_i)
    else
      store_memory(mem, mask, inst[:pos], format('%036b', inst[:value]))
    end
  end
  sum = 0
  mem.each do |_, v|
    sum += part_two ? v : v.to_i(2)
  end
  sum
end

def part_two(input)
  part_one(input, true)
end

bitmask = input_file
puts "Day 14 - Part 1 --> Sum: #{part_one(bitmask)}"
puts "Day 14 - Part 2 --> Sum: #{part_two(bitmask)}"
