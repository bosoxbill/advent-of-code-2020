h = Hash.new
valid = Array.new
invalid = Array.new

File.open('input.txt', 'r') do |f|
  f.each_line do |line|
    range, letter_with_colon, password = line.split(' ')
    min, max = range.split('-')
    letter = letter_with_colon.chars.first
    range = (min.to_i..max.to_i)
    count = password.count(letter)
    if range.member?(count)
      valid << password
    else
      #puts "password not valid: #{line} (#{min}, #{max}, #{letter}, #{count})"
      invalid << password
    end
  end
end

puts "#{valid.count} valid passwords, #{invalid.count} invalid"

