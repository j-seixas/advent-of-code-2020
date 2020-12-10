# frozen_string_literal: true

require './utils/utils'

def input_file
  get_file('inputs/day_05.txt').map do |seat|
    {
      row: seat[0..7].gsub('B', '1').gsub('F', '0').to_i(2),
      seat: seat[7..-1].gsub('R', '1').gsub('L', '0').to_i(2)
    }
  end
end

def part_one(input, max = 0)
  input.each do |v|
    id = v[:row] * 8 + v[:seat]
    max = id if id > max
  end
  max
end

def part_two(input)
  seats = input.map { |v| v[:row] * 8 + v[:seat] }
  seats.each do |v|
    return v + 1 if !seats.include?(v + 1) && seats.include?(v + 2)
    return v - 1 if !seats.include?(v - 1) && seats.include?(v - 2)
  end
end

boarding_passes = input_file
puts "Day 5 - Part 1 --> Highest: #{part_one(boarding_passes)}"
puts "Day 5 - Part 2 --> Seat ID: #{part_two(boarding_passes)}"
