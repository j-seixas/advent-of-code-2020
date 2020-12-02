File.open('inputs/input_day_01.txt', 'r') do |f|
  break_it = false
  values = f.readlines.map(&:chomp).map(&:to_i)
  values.each_with_index do |value, index|
    values[(index + 1)..-1].each do |v|
      if value + v == 2020
        puts "#{value}, #{v} - result: #{v * value}"
        break_it = true
        break
      end
    end
    break if break_it
  end
end
