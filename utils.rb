# frozen_string_literal: true

def get_file(filename)
  File.open(filename, 'r') do |f|
    content = f.readlines.map(&:chomp)
    puts "Error reading file #{filename}" unless content
    content
  end
end
