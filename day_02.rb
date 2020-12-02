passwords = nil
File.open('inputs/input_day_02.txt', 'r') do |f|
  passwords = f.readlines.map(&:chomp).map do |policy|
    splitted = policy.split(' ')
    {
      min: splitted[0].split('-')[0].to_i,
      max: splitted[0].split('-')[1].to_i,
      word: splitted[1].gsub(':', ''),
      password: splitted[2]
    }
  end
end

return unless passwords

# puzzle 1
total = 0
passwords.each do |password|
  count = password[:password].count(password[:word])
  total += 1 if count >= password[:min] && count <= password[:max]
end

puts total
