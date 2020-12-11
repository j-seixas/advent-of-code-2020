# frozen_string_literal: true

def get_file(filename)
  File.open(filename, 'r') do |f|
    content = f.readlines.map(&:chomp)
    puts "Error reading file #{filename}" unless content
    content
  end
end

def get_file_unprocessed(filename)
  File.open(filename, 'r') do |f|
    content = f.read
    puts "Error reading file #{filename}" unless content
    content
  end
end

def match_regex?(input, expression)
  !!(input =~ expression)
end

def deep_copy(array)
  array.map(&:dup)
end
