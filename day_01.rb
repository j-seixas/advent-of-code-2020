values = nil
File.open('inputs/input_day_01.txt', 'r') do |f|
  values = f.readlines.map(&:chomp).map(&:to_i)
end

return unless values

# puzzle 01
break_it = false
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

# puzzle 02
break_it = false
values.each_with_index do |value, index|
  values[(index + 1)..-1].each_with_index do |v, i|
    values[(i + 1)..-1].each do |j|
      if value + v + j == 2020
        puts "#{value}, #{v}, #{j} - result: #{v * value * j}"
        break_it = true
        break
      end
    end
    break if break_it
  end
  break if break_it
end
